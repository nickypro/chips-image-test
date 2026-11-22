# Your environment, built off the platform and run with `chips run --image` (see BUILD_YOUR_IMAGE.md).
# Keep code that changes often in /workspace; put the slow-to-install things here.

# The base: PyTorch 2.15 with CUDA 13.2, pinned by digest so a rebuild starts from the same bytes. Any public
# linux/amd64 image with bash works; the list of tested ones is in IMAGES.md.
ARG BASE=docker.io/pytorch/pytorch:2.15.0-cuda13.2-cudnn9-runtime@sha256:924707fa828f821c9a82d987b405675df6369eee5ce368aece6757b025ffcde5
FROM ${BASE}

# System packages, if you need any. Jobs run your command with bash, so the image must have it (this base does).
# RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

# Python packages, added to the base's own Python (where its torch is). Pin versions in requirements.txt so the next
# build gets the same ones. --break-system-packages is how pip installs there in this base, as the base did for torch;
# it's harmless in an image. If pip wants to replace torch or numpy, a package needs other versions than the base's.
COPY requirements.txt /opt/env/requirements.txt
RUN python3 -m pip install --no-cache-dir --break-system-packages -r /opt/env/requirements.txt

# Don't put anything under /workspace, /models, /scratch or /dev/shm: jobs mount over those paths.
# Don't set USER: jobs run as the image's user, and the files in your /workspace belong to root.
# No ENTRYPOINT or CMD is needed: chips run replaces them with your command.
# Never COPY a token, key or .env file: this image is public.
