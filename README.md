# infrastructure

The purpose of `infrastructure` is to have a central repo from where you can
locally run the whole microservice architecture using Docker Compose.

## Getting started

1) Extract keys from `/keys`.

2) Use make to start/stop:
```sh
make

# Or...
make run # Build and run, same as `make`
make build # Build
make down # Shut down
```

## Environment variables

This is the assumed project layout on your computer:
```yaml
./
    - infrastructure/
        compose.yml
        default.env
        run.sh
    - user-service/
        src/
            Dockerfile
    ...
```

Infrastructure's `compose.yml` reads the Dockerfile of each microservice locally
based on its relative location which specified in `default.env`.

If you have a different project layout, create an `override.env` file and write the correct relative paths on your computer. `override.env` is not tracked by git, so there will be no conflicts.