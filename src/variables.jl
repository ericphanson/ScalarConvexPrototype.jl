function variable(m::Model{T}) where {T}
    v = MOI.add_variable(moi_model(m))
    return AbstractExpr{T}(m, v, NoSign(), AffineVexity())
end

function constant(::Type{T}, n::Number) where {T}
    n = convert(T, n)
    return AbstractExpr{T}(nothing, n, sign(n), vexity(n))
end

function variables(m::Model{T,M}, size::Integer...) where {T,M}
    arr = Array{AbstractExpr{T,typeof(m),MOI.VariableIndex}}(undef, size...)
    @. arr = variable(m)
    return arr
end
