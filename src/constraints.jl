function Base.:(>=)(a::AbstractExpr{T}, n::Number) where {T}
    model = moi_model(a)
    func, set = MOIU.normalize_constant(a.head, MOI.GreaterThan(convert(T, n)))
    if func isa MOI.VariableIndex
        ci = MOI.ConstraintIndex{MOI.VariableIndex,MOI.GreaterThan{T}}(func.value)
        if MOI.is_valid(model, ci)
            s_greater_than = MOI.get(model, MOI.ConstraintSet(), ci)
            # Update the bound if tighter, otherwise do nothing
            if s_greater_than.lower >= set.lower
                MOI.set(model, MOI.ConstraintSet(), ci, set)
            end
        else
            @goto default
        end
    else
        @label default
        return MOI.add_constraint(moi_model(a), func, set)
    end
end

function Base.:(==)(a::AbstractExpr{T}, n::Number) where {T}
    return MOIU.normalize_and_add_constraint(moi_model(a), a.head, MOI.EqualTo(convert(T, n)))
end

function Base.:(>=)(a::AbstractExpr{T}, b::AbstractExpr) where {T}
    difference = operate(-, a, b)
    return difference >= zero(T)
end

function Base.:(<=)(a::AbstractExpr{T}, n::Number) where {T}
    return MOIU.normalize_and_add_constraint(moi_model(a), a.head, MOI.LessThan(convert(T, n)))
end
