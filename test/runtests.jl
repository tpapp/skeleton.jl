# very informal testing, just see if things run

BINPATH = normpath(joinpath(@__DIR__, "..", "skeleton.jl"))
USERNAME = "Joe H. User"
USEREMAIL = "test@email.domain"
GHUSER = "somethingclever"
setgitopt(name, value) = run(`git config --global --add $(name) $(value)`)

# generate random package
cd(tempdir())
pkgname = string(rand('A':'Z', 5)...)
run(`$(BINPATH) $(pkgname)`)
cd(pkgname)
setgitopt("user.name", USERNAME)
setgitopt("user.email", USEREMAIL)
setgitopt("github.user", GHUSER)

# test documentation generation
run(`julia --project=docs -e 'using Pkg; Pkg.instantiate()'`)
run(`julia --project=docs --color=yes docs/make.jl`)

# test that coverage is instantiated (not generating or submitting)
run(`julia --project=test/coverage -e 'using Pkg; Pkg.instantiate()'`)
