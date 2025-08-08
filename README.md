# infrastructure

The purpose of `infrastructure` is to have a central repo from where you can
locally run the whole microservice architecture using Docker Compose.

## Getting started

1) Extract keys from `/keys`.

2) Use make:
```sh
make       # Build and run
make run   # Build and run
make build # Just build
make down  # Shut down

make PROFILE=full       # Build and run, including the web app
make run PROFILE=full   # Build and run, including the web app
make build PROFILE=full # Just build, including the web app
make down PROFILE=full  # Shut down, including the web app

# See `Makefile` for usage
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