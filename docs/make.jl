using Convex2
using Documenter

DocMeta.setdocmeta!(Convex2, :DocTestSetup, :(using Convex2); recursive=true)

makedocs(;
    modules=[Convex2],
    authors="Eric P. Hanson",
    sitename="Convex2.jl",
    format=Documenter.HTML(;
        canonical="https://ericphanson.github.io/Convex2.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ericphanson/Convex2.jl",
    devbranch="main",
)
