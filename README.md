# skeleton.jl

Julia script for creating new packages quickly. **Needs at least Julia version v0.7-beta**.

## Usage

From a shell,

```sh
julia skeleton.jl destination/directory [template]
```

Then

1. if the destination directory does not exist, `Pkg.generate` is called,

2. files in `template` will be copied recursively, with the text `SKELETON` replaced by the package name, which is obtained as the last part of the directory.

3. `git init` is called.
