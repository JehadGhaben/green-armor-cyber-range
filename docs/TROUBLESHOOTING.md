# Troubleshooting

## Docker command not found

Install Docker Engine or Docker Desktop and confirm:

```bash
docker --version
docker compose version
```

## Permission denied when running scripts

```bash
chmod +x *.sh tests/*.sh
```

## Docker daemon is not running

On Linux:

```bash
sudo systemctl start docker
```

With Docker Desktop, start Docker Desktop and wait until the engine is ready.

## Build problem after changing files

Rebuild from a clean lab state:

```bash
./stop.sh
docker compose build --no-cache
./start.sh
```

## Container is unhealthy

Check status and logs:

```bash
./status.sh
docker compose logs --no-color
```

For one service:

```bash
docker compose logs ga-pivot
docker compose logs ga-internal-web
```

## Self-test reports FAIL

Run:

```bash
./status.sh
docker compose logs --no-color
./tests/self-test.sh
```

Confirm that all four containers are running and healthy before troubleshooting the specific failed test.

## Reset the entire lab

```bash
./reset.sh
```

This removes the current containers and recreates the lab environment.

## Windows

Use Docker Desktop with the WSL2 backend. Run the repository from a WSL2 terminal for the most consistent shell-script behavior.
