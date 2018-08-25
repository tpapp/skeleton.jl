#!/usr/bin/env julia

using Pkg

minver = v"0.7"

err(msg) = (printstyled(stderr, msg * '\n'; bold = true, color = :blue); exit(1))

VERSION ≥ minver || err("need at least version $(minver)")

1 ≤ length(ARGS) ≤ 2 || err("Usage: [julia] skeleton.jl destination [template]")

destdir = ARGS[1]

isfile(destdir) && err("destination $(destdir) is a file")

template = length(ARGS) == 2 ? ARGS[2] : "template"

pkgname = basename(destdir)

if isempty(pkgname)
    pkgname = basename(dirname(destdir)) # trailing /
end

@info "package name is \"$(pkgname)\", using template \"$(template)\""

if isdir(destdir)
    @info "destination directory exists, skipping package generation"
else
    @info "destination directory does not exist, calling `Pkg.generate`"
    Pkg.API.generate(destdir)
end

const thisdir = @__DIR__

srcroot = joinpath(thisdir, template)

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
            deststring = replace(srcstring, "SKELETON" => pkgname)
            write(destfile, deststring)
        end
    end
end

@info "calling git init"
run(`git init $destdir`)
