using Convex2, Clarabel
using Test

@testset "Convex2.jl" begin
    @testset "a" begin
        model = Model(MOI.instantiate(Clarabel.Optimizer{Float64}; with_bridge_type=Float64))
        t = variable(model)
        pos_t = max(t, 0)
        t <= -1
        t >= -5
        t >= -4
        minimize!(pos_t)

        @test evaluate(pos_t) ≈ 0 atol=1e-4
    end

    @testset "b" begin
        model = Model(MOI.instantiate(Clarabel.Optimizer{Float64}; with_bridge_type=Float64))
        mat = variables(model, 2, 2)
        mat[1,1] >= 1
        mat[2,2] <= -1
        minimize!(Convex2.norm2(mat))
        @test evaluate.(mat) ≈ [1 0; 0 -1]
    end
end
