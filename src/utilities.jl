function operate(op, a::AbstractExpr{T}, b::AbstractExpr; sign=UncomputedSign(), vexity=UncomputedVexity()) where {T}
    difference = MOIU.operate(op, T, a.head, b.head)
    return AbstractExpr{T}(a.model, difference, sign, vexity)
end

function evaluate(x::AbstractExpr; result=1)
    model = moi_model(x)
    return MOIU.eval_variables(v -> MOI.get(model, MOI.VariablePrimal(result), v), model, x.head)
end

function minimize!(a::AbstractExpr)
    model = moi_model(a)
    MOI.set(
           model,
           MOI.ObjectiveFunction{typeof(a.head)}(),
           a.head,
       );

    MOI.set(model, MOI.ObjectiveSense(), MOI.MIN_SENSE)

    if a.vexity == ConcaveVexity()
        return DCPViolationError()
    end
    
    return MOI.optimize!(model)
end

function solve!(m::Model)
    MOI.optimize!(moi_model(m))
end
