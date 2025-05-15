# Desk Skeleton

A basic desk skeleton and dependency management approach for Urbit app development. 

No more symlinks and dependency hell across kernel updates.

## Requirements

This setup uses [peru](https://github.com/buildinspace/peru) to manage external dependencies. You can install it with:
- [pip](https://pypi.org/project/pip/): `pip install peru`
- [Homebrew](https://brew.sh/): `brew install peru`
- The [AUR](https://aur.archlinux.org/packages/peru) if you use Arch Linux

## Installation

Fork the repo and git clone it. [Install peru](#requirements) then run `./build.sh` to fetch dependencies and compile a desk.

You can then spin up a fakezod, run `|new-desk %example` and `|mount %example` in the Dojo, copy the contents of the `dist` folder in, `|commit %example`, and `|install our %example`. The included example app will then be running in Landscape.
    
## Structure

The repo contains two folders and two files:

- `desk`: where you add your source code like agents, libraries, threads, etc. This should follow a standard desk structure (`app`, `sur`, `lib`, `mar`, etc).
- `desk-dev`: an optional separate folder for marks and libraries that other developers integrating with your app might need. These shared libraries are pulled in by `build.sh` so you don't need to keep copies in both `desk` and `desk-dev`.
- `peru.yaml`: dependency configuration. This is where you specify what files you need from external repos. By default it includes [`base-dev`](https://github.com/urbit/urbit/tree/develop/pkg/base-dev) from [urbit/urbit](https://github.com/urbit/urbit) and [`landscape-dev`](https://github.com/tloncorp/landscape/tree/develop/desk-dev) from [tloncorp/landscape](https://github.com/tloncorp/landscape).
- `build.sh`: A script to copy the `desk` and `desk-dev` contents into a `dist` folder along with the remote dependencies via peru.

You can optionally include a separate `peru-dev.yaml` file to pull any external developer dependencies into a `dist-dev` folder along with the contents of `desk-dev`. This can be done by running `./build build-dev`.

## build.sh

This script brings together the files in `desk` and `desk-dev`, pulls remote dependencies, and puts them all together in a `dist` folder which can be committed to a ship and run.

When run without any arguments, it builds `dist` as described. Other arguments are:

- `build`: the same as without arguments, builds `dist`.
- `build-dev`: builds `dist-dev` from the contents of `desk-dev` and any remote dependencies specified in the optional `peru-dev.yaml`.
- `clean`: deletes `dist` and `dist-dev`
- `help`: prints these options.

You can run `./build.sh` each time you change anything to rebuild `dist`, you don't need to run `./build.sh clean` between changes.

## Dependency management

All remote dependencies are configured in the `peru.yaml` file (or `peru-dev.yaml` for the developer stuff). You can look at the included `peru.yaml` to see how entries look and refer to the [peru readme](https://github.com/buildinspace/peru) for detail configuration instructions.

The default `peru.yaml` specifies the latest commit from the `master` branch of `base-dev` and `landscape-dev` at the time this repo was last updated. If there's a kernel update down the line and you need to update those libraries, you can simply run `peru reup` to update `peru.yaml` to the latest commits. Then you just run `./build.sh` to rebuild `dist`.

You can of course add additional entries in `peru.yaml` for other libraries you need. Everything is managed in the one place and can be kept up-to-date with a single command.

## Frontends

This system is intended for managing desk dependencies. If you have a separate front-end written in something like React, I'd suggest you create a `ui` directory and manage it there as you usually would.
