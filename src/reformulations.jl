# `max`
function Base.max(a::AbstractExpr{T}, b::Union{AbstractExpr,Number}) where {T}
    model = get_model(a, b)
    t = variable(model)
    t >= a
    t >= b
    # Eager computation of vexity
    vex = ConvexVexity()
    vex += Nondecreasing() * vexity(a) # a
    vex += Nondecreasing() * vexity(b) # b
    return AbstractExpr{T}(model, t.head, sign(a) + sign(b), vex)
end
Base.max(n::Number, a::AbstractExpr) = max(a, n)

# `+`
function Base.:(+)(a::AbstractExpr{T}, b::AbstractExpr) where {T}
    model = get_model(a, b)
    head = MOIU.operate(+, T, a.head, b.head)
    return AbstractExpr{T}(model, head, sign(a) + sign(b), vexity(a) + vexity(b))
end
Base.:(+)(a::AbstractExpr{T}, n::Number) where {T} = n == zero(T) ? a : a + constant(T, n)
Base.:(+)(n::Number, a::AbstractExpr{T}) where {T} = n == zero(T) ? a : constant(T, n) + a


# `norm2`
numeric_type(::AbstractExpr{T}) where {T} = T
function norm2(a::AbstractArray)
    model = get_model(a[1])
    T = numeric_type(a[1])
    t = variable(model)
    f = MOIU.operate(vcat, T, t.head, (x.head for x in a)...)
    MOI.add_constraint(moi_model(model), f, MOI.SecondOrderCone(length(a) + 1))
    vex = ConvexVexity()
    for ai in a
        vex += sign(ai) * Nondecreasing() * vexity(ai)
    end
    return AbstractExpr{T}(model, t.head, Positive(), vex)
end
