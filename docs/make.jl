using ScalarConvexPrototype
using Documenter

DocMeta.setdocmeta!(ScalarConvexPrototype, :DocTestSetup, :(using ScalarConvexPrototype); recursive=true)

makedocs(;
    modules=[ScalarConvexPrototype],
    authors="Eric P. Hanson",
    sitename="ScalarConvexPrototype.jl",
    format=Documenter.HTML(;
        canonical="https://ericphanson.github.io/ScalarConvexPrototype.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ericphanson/ScalarConvexPrototype.jl",
    devbranch="main",
)
