module Convex2

import MathOptInterface as MOI
import MathOptInterface.Utilities as MOIU
using Test

export MOI, MOIU
export Model, variable, variables, solve!, evaluate

include("foundation.jl")
include("dcp.jl")
include("constraints.jl")
include("reformulations.jl")
include("utilities.jl")
include("variables.jl")

function test()
    model = Model(MOI.instantiate(Clarabel.Optimizer{Float64}; with_bridge_type=Float64))
    v = variable(model)
    v + 1 == 0
    solve!(model)
    @test evaluate(v) == -1
    t = max(v, 1)
    t >= 0
    solve!(model)
    evaluate(t + 2)
end


end # module
