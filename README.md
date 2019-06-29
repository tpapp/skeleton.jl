# skeleton.jl

<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg) -->
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
<!-- ![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.org/tpapp/skeleton.jl.svg?branch=master)](https://travis-ci.org/tpapp/skeleton.jl)

Julia script for creating new packages quickly. **Needs at least Julia version v0.7-beta**.

## IMPORTANT

This software has been superseded by the packaged version of the same concept, available at

https://github.com/tpapp/PkgSkeleton.jl

The repository is now archived.

## Installation

This is **not a package, just a script**. Clone from the repository, eg

```sh
git clone https://github.com/tpapp/skeleton.jl.git
```

## Usage

From a shell,

```sh
julia path/to/skeleton.jl destination/directory [template]
```

Then

1. files in `template` will be copied recursively, with various substitutions which are in the source code as `replacements`.

2. A git repo is initialized.

If the destination directory exists, the script aborts.

After this, you probably want to `pkg> dev destination/directory` in Julia, and add your Github repository as a remote.

## Prerequisites

For the default template, you need to set the `git` configuration variables `user.name`, `user.email`, and `github.user`.

## Design

[KISS](https://en.wikipedia.org/wiki/KISS_principle): does nothing more than substitute strings into templates. For me, this covers 99% of the use cases; the rest I edit manually.

~~At this point, I have no intention of making this into a package, let alone registering it.~~ Eating my words here: since I realized I need unit tests, this may evolve into a package. But not in the medium run.

Templates replace the following in files *and filenames*:

| string        | replacement                                      |
|---------------|--------------------------------------------------|
| `{UUID}`      | a randomly generated UUID1                       |
| `{PKGNAME}`   | name of the package, first command line argument |
| `{GHUSER}`    | `git config --get github.user`                   |
| `{USERNAME}`  | `git config --get user.name`                     |
| `{USEREMAIL}` | `git config --get user.email`                    |
