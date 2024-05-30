struct FactorTree
    value::Int
    left::Union{Nothing, FactorTree}
    right::Union{Nothing, FactorTree}
end

function FactorTree(v::Int)
    if isprime(v)
        return FactorTree(v, nothing, nothing)
    else
        a, b = best_factor_pair(v)
        return FactorTree(v, FactorTree(a), FactorTree(b))
    end
end

function isprime(n::Int)
    if n <= 1
        return false
    elseif n <= 3
        return true
    elseif n % 2 == 0 || n % 3 == 0
        return false
    end
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end
    return true
end

function best_factor_pair(n::Int)
    best_a, best_b = 1, n
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            a, b = i, div(n, i)
            if b - a < best_b - best_a
                best_a, best_b = a, b
            end
        end
    end
    return best_a, best_b
end

function getFactors(t::FactorTree)::Dict{Int, Int}
    factors = Dict{Int, Int}()
    function _getFactors(t::FactorTree)
        if isprime(t.value)
            factors[t.value] = get(factors, t.value, 0) + 1
        else
            _getFactors(t.left)
            _getFactors(t.right)
        end
    end
    _getFactors(t)
    return factors
end

function getShape(t::FactorTree)::String
    if isprime(t.value)
        return "p"
    elseif isprime(t.left.value) && isprime(t.right.value)
        return "p2"
    else
        return "f(" * getShape(t.left) * "|" * getShape(t.right) * ")"
    end
end

function compareShape(t1::FactorTree, t2::FactorTree)::Bool
    return getShape(t1) == getShape(t2)
end

function computeShapes(n::Int)::Dict{String, Vector{Int}}
    shapes_dict = Dict{String, Vector{Int}}()
    for i in 1:n
        if i == 1
            shape = "p"
        else
            t = FactorTree(i)
            shape = getShape(t)
        end
        if haskey(shapes_dict, shape)
            push!(shapes_dict[shape], i)
        else
            shapes_dict[shape] = [i]
        end
    end
    return shapes_dict
end


# Beispiel
#t = FactorTree(20)
#getFactors(t)                # Dict{Int, Int64} with 2 entries: 5 => 1, 2 => 2
#getShape(t)                  # "f(p2|p)"
#t2 = FactorTree(945)
#t3 = FactorTree(72)
#compareShape(t2, t3)         # true
#computeShapes(10)            # Dict{String, Vector{Int64}}