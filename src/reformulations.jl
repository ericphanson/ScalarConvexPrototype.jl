function Base.max(a::AbstractExpr{T}, b::Union{AbstractExpr, Number}) where {T}
    t = variable(a.model)
    t >= a
    t >= b
    # Eager computation of vexity
    vex = ConvexVexity()
    vex += Nondecreasing() * vexity(a) # a
    vex += Nondecreasing() * vexity(b) # b
    return AbstractExpr{T}(t.model, t.head, sign(a) + sign(b), vex)
end
Base.max(n::Number, a::AbstractExpr) = max(a, n)

function Base.:(+)(a::AbstractExpr{T}, n::Number) where {T}
    head = MOIU.operate(+, T, a.head, convert(T, n))
    return AbstractExpr{T}(a.model, head, a.sign, a.vexity)
end
