# Definieren des Typs Set
struct Set
    _elements::Vector{Tuple{Int, Int}}
end

# Initialisieren eines Sets mit einer gegebenen Liste von Tupeln
function Set(V::Vector{Tuple{Int, Int}})
    # Prüfen, ob es doppelte Elemente gibt
    length(unique(V)) != length(V) && throw("invalid operation")
    return Set(sort(V))
end

# Gibt die Elemente des Sets zurück
elements(s::Set) = s._elements

# Definieren des Typs Partition
struct Partition
    Sets::Vector{Set}
end

# Initialisiert eine Partition von V in einelementige Mengen
function Partition(V::Vector{Tuple{Int, Int}})
    # Prüfen, ob es doppelte Elemente gibt
    length(unique(V)) != length(V) && throw("invalid operation")
    sets = [Set([(x, y)]) for (x, y) in V]
    return Partition(sets)
end

# String-Repräsentation eines Partition-Objekts
Base.show(io::IO, P::Partition) = print(io, [elements(s) for s in P.Sets])

# Fügt der Liste Sets ein Set-Objekt hinzu, das mit dem Tupel (x, y) initialisiert wird
function MakeSet!(P::Partition, xy::Tuple{Int, Int})
    for set in P.Sets
        xy ∈ elements(set) && throw("invalid operation")
    end
    push!(P.Sets, Set([xy]))
end

# Findet das Set, das das Tupel (x,y) enthält und gibt das Repräsentanten-Tupel zurück
function FindSet(P::Partition, xy::Tuple{Int, Int})
    for set in P.Sets
        if xy ∈ elements(set)
            return elements(set)[1]
        end
    end
    throw("invalid operation")
end

# Bildet die Vereinigung zweier Sets in der Partition, deren Repräsentanten (x1,y1) bzw. (x2,y2) sind
function Union!(P::Partition, xy1::Tuple{Int, Int}, xy2::Tuple{Int, Int})
    index1, index2 = nothing, nothing 
    for i in 1:length(P.Sets)
        if elements(P.Sets[i])[1] == xy1
            index1 = i
        elseif elements(P.Sets[i])[1] == xy2
            index2 = i
        end
    end
    
    if index1 !== nothing && index2 !== nothing
        # Kombinieren der Elemente und Entfernen der alten Sets
        new_set_elements = unique(vcat(elements(P.Sets[index1]), elements(P.Sets[index2])))
        new_set = Set(sort(new_set_elements))
        deleteat!(P.Sets, [index1, index2])
        push!(P.Sets, new_set)
    else
        throw("invalid operation")
    end
end


S = Partition([(0, 3), (0, 1), (1, 3), (1, 0)])
Union!(S, (1, 3), (0, 1))
Union!(S, (0, 3), (0, 1))
println(S)
println(FindSet(S, (1, 3)))
MakeSet!(S, (300, 1))
Union!(S, (300, 1), (0, 1))
println(S)
println(FindSet(S, (300, 1)))
MakeSet!(S, (0, 0))
Union!(S, (0, 0), (0, 1))
println(FindSet(S, (300, 1)))
println(S)