makedocs(
    modules = [{PKGNAME}],
    format = :html,
    sitename = "${PKGNAME}.jl",
    pages = Any["index.md"]
)

deploydocs(
    repo = "github.com/{GHUSER}/{PKGNAME}.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
