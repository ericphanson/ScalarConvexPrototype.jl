function variable(m::Model{T}) where {T}
    v = MOI.add_variable(moi_model(m))
    return AbstractExpr{T}(m, v, NoSign(), AffineVexity())
end

function variables(m::Model{T,M}, size::Integer...) where {T,M}
    arr = Array{AbstractExpr{T,M,MOI.VariableIndex}}(undef, size...)
    @. arr = variable(m)
    return arr
end
