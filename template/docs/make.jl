using Documenter, {PKGNAME}

makedocs(
    modules = [{PKGNAME}],
    format = :html,
    sitename = "{PKGNAME}.jl",
    pages = Any["index.md"]
)

deploydocs(
    repo = "github.com/{GHUSER}/{PKGNAME}.jl.git",
    target = "build",
    julia = "1.0",
    deps = nothing,
    make = nothing,
)
