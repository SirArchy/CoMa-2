struct TupleSet
    elements::Vector{Tuple{Int, Int}}
    
    function TupleSet(V::Vector{Tuple{Int, Int}})
        new(sort(V))
    end
end

struct Partition
    Sets::Vector{TupleSet}
end

# Erzeugt eine Partition von V in ein-elementige Mengen
function Partition(V::Vector{Tuple{Int, Int}})
    sets = TupleSet.(V)
    return Partition(sets)
end

# Fügt der Liste Sets ein Set-Objekt hinzu, das mit dem Tupel (x,y) initialisiert wird
function MakeSet(P::Partition, tuple::Tuple{Int, Int})
    # Überprüfen, ob das Tupel bereits in einem TupleSet enthalten ist
    for set in P.sets
        if tuple in set.elements
            return
        end
    end
    # Das Tupel ist nicht enthalten, fügen Sie es hinzu
    push!(P.sets, TupleSet([tuple]))
end

# Gibt das Repräsentanten-Tupel S[0] zurück
function FindSet(P::Partition, tuple::Tuple{Int, Int})
    for set in P.sets
        if tuple in set.elements
            return set.elements[1]
        end
    end
    # Das Tupel ist nicht enthalten
    return -1
end

# Vereinigt zwei Sets
function union!(P::Partition, tuple1::Tuple{Int, Int}, tuple2::Tuple{Int, Int})
    set1 = nothing
    set2 = nothing
    
    # Finden Sie die Sets, die tuple1 und tuple2 enthalten
    for set in P.sets
        if tuple1 in set.elements
            set1 = set
        elseif tuple2 in set.elements
            set2 = set
        end
        if !(isnothing(set1) || isnothing(set2))
            break
        end
    end
    
    # Wenn tuple1 und tuple2 in keinem Set enthalten sind, machen Sie nichts
    if isnothing(set1) || isnothing(set2)
        return
    end
    
    # Entfernen Sie die alten Sets und fügen Sie ein neues Set hinzu
    new_elements = sort(unique(vcat(set1.elements, set2.elements)))
    P.sets = [set for set in P.sets if !(set == set1 || set == set2)]
    push!(P.sets, TupleSet(new_elements))
end


S = TupleSet([(0,3),(0,1),(1,3),(1,0)])
P = Partition(S)

println(union!(P,(1,3),(0,1)).Sets)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(0,3)]
# [(1,0)]
# [(0,1),(1,3)]
println(union!(P,(0,1),(0,3)).Sets)
# 2−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(1,0)]
# [(0,1),(0,3),(1,3)]
println(FindSet(P,(0,3)))
# (0,1)
println(MakeSet(P,(300,1)).Sets)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(1,0)]
# [(0,1),(0,3),(1,3)]
# [(300,1)]
println(union!(P,(300,1),(0,1)).Sets)
# 2−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(1,0)]
# [(0,1),(0,3),(1,3),(300,1)]
#=
=#


#= Input: [(1,3),(2,1)]
Erwarteter Output: [(1, 3), (2, 1), (457, 23), (457, 501), (342, 11), (110, 1), (110, 2)]
All Good
(110, 1)
=#