struct Set{T}
    _elements::Vector{T}

    function Set(V::Vector{T}) where T
        new{T}(sort(V))
    end
end

function Base.show(io::IO, s::Set)
    print(io, sort(s._elements))
end

struct Partition{T}
    sets::Vector{Set{T}}

    function Partition(V::Vector{T}) where T
        elements = Set{T}[]
        for tup in V
            if any(isequal(tup) in map(y -> y._elements, elements))
                throw(ArgumentError("invalid operation"))
            end
            push!(elements, Set([tup]))
        end
        new{T}(elements)
    end
end

function Base.show(io::IO, p::Partition)
    print(io, map(s -> s._elements, p.sets))
end

function MakeSet!(p::Partition, tup)
    if any(isequal(tup) in map(y -> y._elements, p.sets))
        throw(ArgumentError("invalid operation"))
    end
    push!(p.sets, Set([tup]))
end

function FindSet(p::Partition, tup)
    for s in p.sets
        if tup in s._elements
            return s._elements[1]
        end
    end
    throw(ArgumentError("invalid operation"))
end

function Union!(p::Partition, tup1, tup2)
    set1_index = set2_index = nothing
    for (index, s) in enumerate(p.sets)
        if tup1 in s._elements
            set1_index = index
        elseif tup2 in s._elements
            set2_index = index
        end
    end

    if isnothing(set1_index) || isnothing(set2_index)
        throw(ArgumentError("invalid operation"))
    end

    set1 = p.sets[set1_index]
    set2 = p.sets[set2_index]
    new_set_elements = union(set1._elements, set2._elements)
    new_set = Set(new_set_elements)

    deleteat!(p.sets, [set1_index, set2_index])
    push!(p.sets, new_set)
end

# Example usage
S = Partition([(0,3), (0,1), (1,3), (1,0)])
Union!(S, (1,3), (0,1))
Union!(S, (0,3), (0,1))
println(S)
println(FindSet(S, (1,3)))
MakeSet!(S, (300,1))
Union!(S, (300,1), (0,1))
println(S)
println(FindSet(S, (300,1)))
MakeSet!(S, (0,0))
Union!(S, (0,0), (0,1))
println(S)
println(FindSet(S, (300,1)))