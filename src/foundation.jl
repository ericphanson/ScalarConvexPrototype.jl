struct Model{T,M}
    model::M
end
Model(model::M) where {M} = Model{Float64,M}(model)
moi_model(m::Model) = m.model

struct AbstractExpr{T,M,O}
    model::M
    head::O
    sign::Sign
    vexity::Vexity
end
AbstractExpr{T}(model::M, head::O, sign::Sign, vexity::Vexity) where {T,M,O} = AbstractExpr{T,M,O}(model, head, sign, vexity)
Base.Broadcast.broadcastable(a::AbstractExpr) = Ref(a) # broadcast like a scalar

moi_model(a::AbstractExpr) = moi_model(a.model)
