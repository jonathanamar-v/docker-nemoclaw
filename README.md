# Docker + NemoClaw for Workbench

Custom Workbench app providing Node.js 22, Docker CLI, and NVIDIA NemoClaw CLI in a single container.

## What's Included

- **Node.js 22** (bookworm-slim base)
- **Docker CLI** + Compose plugin (via host socket mount)
- **NemoClaw CLI** (NVIDIA)

## Deploy on Workbench

1. Go to your workspace > **Apps** > **Create App** > **Custom App**
2. Set:
   - **Repository:** `https://github.com/jonathanamar-v/docker-nemoclaw.git`
   - **Branch:** `master`
   - **Folder:** `.`
3. Choose a machine type and create

## Local Testing

```bash
docker network create app-network
docker compose up --build
```

## Files

| File | Purpose |
|------|---------|
| `.devcontainer.json` | Devcontainer config (must be at repo root) |
| `docker-compose.yaml` | Mounts host Docker socket, sets up `app-network` |
| `Dockerfile` | Builds image with Node.js 22, Docker CLI, NemoClaw |
| `docker-setup.sh` | Matches container Docker GID to host socket GID |
| `devcontainer-template.json` | Workbench template metadata |
