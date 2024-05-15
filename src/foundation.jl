struct Model{T,M}
    model::M
end
Model(model::M) where {M} = Model{Float64,M}(model)
moi_model(m::Model) = m.model
Base.Broadcast.broadcastable(a::Model) = Ref(a) # broadcast like a scalar

struct AbstractExpr{T,M,O}
    model::M
    head::O
    sign::Sign
    vexity::Vexity
end
AbstractExpr{T}(model::M, head::O, sign::Sign, vexity::Vexity) where {T,M,O} = AbstractExpr{T,M,O}(model, head, sign, vexity)
Base.Broadcast.broadcastable(a::AbstractExpr) = Ref(a) # broadcast like a scalar

moi_model(a::AbstractExpr) = moi_model(a.model)
moi_model(::Nothing) = nothing
function moi_model(a, b)
    return @something(moi_model(a), moi_model(b))
end
get_model(a::AbstractExpr) = a.model
function get_model(a, b)
    return @something(get_model(a), get_model(b))
end

Base.zero(::AbstractExpr{T}) where {T} = zero(T)

function Base.show(io::IO, a::AbstractExpr{T}) where {T}
    println(io, "AbstractExpr{$T}:")
    println(io, "- head: $(a.head)")
    println(io, "- sign: $(a.sign)")
    print(io, "- vexity: $(a.vexity)")
end

# Accessors

vexity(a::AbstractExpr) = a.vexity
vexity(::Number) = ConstVexity()

sign(a::AbstractExpr) = a.sign
sign(n::Number) = n >= 0 ? Positive() : Negative()
