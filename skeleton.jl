#!/usr/bin/env julia

using Pkg, UUIDs

# sanity checks and parsing input arguments

minver = v"0.7"
err(msg) = (printstyled(stderr, msg * '\n'; bold = true, color = :blue); exit(1))
VERSION ≥ minver || err("need at least version $(minver)")
1 ≤ length(ARGS) ≤ 2 || err("Usage: [julia] skeleton.jl destination [template]")
destdir = ARGS[1]
isfile(destdir) && err("destination $(destdir) is a file")
srcdir = length(ARGS) == 2 ? ARGS[2] : joinpath(@__DIR__, "template")
pkgname = basename(destdir)

if isempty(pkgname)
    pkgname = basename(dirname(destdir)) # add trailing /
end

# utility functions

"Get an option from `git`."
function getgitopt(opt)
    try
        chomp(read(`git config --get $(opt)`, String))
    catch
        err("couldn't get option $(opt)")
    end
end

"Replace multiple pairs in `str`, using `replace` iteratively."
function replace_multiple(str, replacements)
    for pair in replacements
        str = replace(str, pair)
    end
    str
end

"""
Copy from `srcdir` to `destdir` recursively, making the substitutions of contents and
filenames using `replacements`.
"""
function copy_and_substitute(srcdir, destdir, replacements)
    for (root, dirs, files) in walkdir(srcdir)
        relroot = relpath(root, srcdir)
        mkpath(normpath(destdir, relroot))
        for file in files
            srcfile = joinpath(root, file)
            destfile = normpath(joinpath(destdir, relroot,
                                         replace_multiple(file, replacements)))
            if isfile(destfile)
                println("$(destfile) exists, skipping")
            else
                println("$(srcfile)  =>  $(destfile)")
                srcstring = read(srcfile, String)
                deststring = replace_multiple(srcstring, replacements)
                write(destfile, deststring)
            end
        end
    end
end


# generate

if isdir(destdir)
    @info "destination directory exists, skipping package generation"
    exit(0)
end

replacements = ["{UUID}" => uuid1(),
                "{PKGNAME}" => pkgname,
                "{GHUSER}" => getgitopt("github.user"),
                "{USERNAME}" => getgitopt("user.name"),
                "{USEREMAIL}" => getgitopt("user.email")]

@info "copy and substitute" srcdir destdir replacements
copy_and_substitute(srcdir, destdir, replacements)

@info "git init"
run(`git init $destdir`)

@info "adding documenter (completing the Manifest.toml for docs)"
run(`julia --project=$(joinpath(destdir, "docs")) -e 'import Pkg; Pkg.add("Documenter")'`)
# cd(destdir)
# run(`git add --all`)
# run(`git commit -am "Initial commit (skeleton.jl)."`)
