#!/usr/bin/env julia

using Pkg, UUIDs

# sanity checks and parsing input arguments

minver = v"0.7"
err(msg) = (printstyled(stderr, msg * '\n'; bold = true, color = :blue); exit(1))
VERSION ≥ minver || err("need at least version $(minver)")
1 ≤ length(ARGS) ≤ 2 || err("Usage: [julia] skeleton.jl destination [template]")
destdir = ARGS[1]
isfile(destdir) && err("destination $(destdir) is a file")
template = length(ARGS) == 2 ? ARGS[2] : "template"
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

function copy_and_substitute(srcroot, destdir, replacements)
    for (root, dirs, files) in walkdir(srcroot)
        relroot = relpath(root, srcroot)
        mkpath(normpath(destdir, relroot))
        for file in files
            srcfile = joinpath(root, file)
            destfile = normpath(joinpath(destdir, relroot, file))
            if isfile(destfile)
                println("$(destfile) exists, skipping")
            else
                println("$(srcfile) -> $(destfile)")
                srcstring = read(srcfile, String)
                deststring = replace_multiple(srcstring, )
                write(destfile, deststring)
            end
        end
    end
end


# replacements

replacements = ["{UUID}" => uuid
                "{PKGNAME}" => pkgname,
                "{GHUSER}" => getgitopt("github.user"),
                "{USERNAME}" => getgitopt("user.name"),
                "{USEREMAIL}" => getgitopt("user.email")]

if isdir(destdir)
    @info "destination directory exists, skipping package generation"
    exit(0)
end

@info "replacements are" replacements

srcroot = joinpath(@__DIR__, template)
copy_and_substitute(srcroot, destdir, replacements)

@info "calling git init"
run(`git init $destdir`)
