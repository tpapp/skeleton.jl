# skeleton.jl

Julia script for creating new packages quickly. **Needs at least Julia version v0.7-beta**.

## Installation

This is not a package, just a script. Clone from the repository.

## Usage

From a shell,

```sh
julia path/to/skeleton.jl destination/directory [template]
```

Then

1. files in `template` will be copied recursively, with various substitutions which are in the source code as `replacements`.

2. `git init` is called.

If the destination directory exists, the script aborts.

After this, you probably want to `pkg> dev destination/directory` in Julia, and add your Github repository as a remote.

## Prerequisites

For the default template, you need to set the `git` configuration variables `user.name`, `user.email`, and `github.user`.

## Design

[KISS](https://en.wikipedia.org/wiki/KISS_principle): does nothing more than substitute strings into templates. For me, this covers 99% of the use cases; the rest I edit manually.
