# skeleton.jl

Julia script for creating new packages quickly. **Needs at least Julia version v0.7-beta**.

## Installation

This is not a package, just a script. Clone from the repository, eg

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

At this point, I have no intention of making this into a package, let alone registering it.

Templates replace the following in files *and filenames*:

|---------------|--------------------------------------------------|
| `{UUID}`      | a randomly generated UUID1                       |
| `{PKGNAME}`   | name of the package, first command line argument |
| `{GHUSER}`    | `git config --get github.user`                   |
| `{USERNAME}`  | `git config --get user.name`                     |
| `{USEREMAIL}` | `git config --get user.email`                    |
