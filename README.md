# Template: an image repository for the MATS GPU platform

Copy everything in this folder (including the hidden `.github` and `.dockerignore`) to the top of a new **public**
GitHub repository. Each push to `main` then builds the image and publishes it to
`ghcr.io/<your-account>/<your-repository>`. The run's summary page prints the `chips run --image ...@sha256:...`
line to use.

The whole walk-through, including the one-time step of making the package public, is
[BUILD_YOUR_IMAGE.md](../BUILD_YOUR_IMAGE.md).

| File | What it is |
|---|---|
| `Dockerfile` | your environment: a pinned PyTorch base plus your packages |
| `requirements.txt` | the Python packages, versions pinned |
| `.dockerignore` | keeps `.git`, data and secrets out of the build |
| `.github/workflows/image.yml` | builds on every push and pull request; publishes from `main` and `v*` tags |
