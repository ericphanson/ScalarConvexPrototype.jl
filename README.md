# Convex2

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ericphanson.github.io/Convex2.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ericphanson.github.io/Convex2.jl/dev/)
[![Build Status](https://github.com/ericphanson/Convex2.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ericphanson/Convex2.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ericphanson/Convex2.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ericphanson/Convex2.jl)

Modeling languages make various choices:

- operator-overloading (Convex) vs macro DSL (JuMP)
- array-based (Convex) vs scalar-based (JuMP)
- lazy expression tree (Convex) vs eager model formulation (JuMP)
- DCP-checking (Convex) vs not (JuMP)

These have various pros and cons. Here, I prototype a different set of choices: operating-overloading, scalar-based, with eager model formulation, and DCP-checking.

I am not sure if this is a better set of choices than what Convex's current set.

What might this gain vs Convex.jl?
- scalar-based could improve performance for some operations, and could make interoperation with standard Julia containers easier
    - also might make it easier to support broadcasting properly
- eager model formulation might reduce frontend complexity (by offloading it to MOI)
- by being more similar to JuMP in these two aspects, it may be easier to support things like parameters

What could cause this to not work well?
- it could be hard to support DCP-checking performantly with a scalar-based model
    - we almost certainly need to use values rather than types for vexity/sign/etc
- using operator-overloading syntax without a lazy expression tree may be hard to make ergonomic
    - in this prototype, `x == y` actually actually adds a constraint, which is not intuitive
