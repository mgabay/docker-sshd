# SSH Server

Simple image of an SSH server built on top of Oracle Linux distribution.

Login is only possible via public key authentication.
Access as root is forbidden.

Single user, single group, no complex parametrization.

---
**WARNING**

This server has a simple ssh configuration. Make sure you configure it properly before using it.

---

## Configuration

Set up options by modifying `config/.env`

### SSH Options

- `SSH_USER`: ssh user name (string)
- `SSH_UID`: ssh user identifier (integer)
- `SSH_GROUP`: ssh user group (string)
- `SSH_GID`: ssh user group identifier (integer)
- `SSH_PORT`: ssh port mapped on host (integer)

### Image Options

- `SSH_IMG`: image name (string)
- `SSH_BASE_IMG`: base image (string)
- `SSH_USE_CACHE`: enable/disable build cache (boolean)

## Building container image

Build the container by running the `build.sh` script from `build` directory.

Build directory contains the following files:

- `build.sh`: build script
- `Dockerfile`: docker build script
- `startup.sh`: the entrypoint, setting up file permissions before running ssh. This is especially useful on Windows hosts

## Running container

The `compose` directory contains:

- `docker-compose.yml`: docker compose deployment script
- `up.sh`: deployment script (accepting arguments)
- `down.sh`: container stop script (accepting arguments)

To deploy container, you first need to **create an `authorized_keys` file** in `compose` folder.
Then, run the `up.sh`:

```bash
cd compose

# Setup authorized keys for $SSH_USER
cat ~/.ssh/id_rsa.pub > authorized_keys

# Run SSH server in detached state
./up.sh -d

# Log into ssh server
source ../config/.env
ssh $SSH_USER@localhost -p$SSH_PORT
```

To stop container, simply run the `down.sh` script:

```bash
# Stop container
./down.sh
```
