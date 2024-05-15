module ScalarConvexPrototype

import MathOptInterface as MOI
import MathOptInterface.Utilities as MOIU

export MOI, MOIU
export Model, variable, variables, solve!, evaluate, minimize!

include("dcp.jl")
include("foundation.jl")
include("constraints.jl")
include("reformulations.jl")
include("utilities.jl")
include("variables.jl")

end # module
