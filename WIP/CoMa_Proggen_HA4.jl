# Definiere den Type Alias TupleSet
const TupleSet = Vector{Tuple{Int, Int}}

# Definiere den Type Partition
struct Partition
    Sets::Vector{TupleSet}
end

# Funktion a) Partition(V::TupleSet)::Partition
function Partition(V::TupleSet)::Partition
    return Partition([V])
end

# Funktion c) MakeSet(P::Partition, (x,y)::Tuple{Int,Int})
function MakeSet(P::Partition, tuple::Tuple{Int,Int})
    for set in P.Sets
        if tuple in set
            return
        end
    end
    push!(P.Sets, [tuple])
end

# Funktion d) FindSet(P::Partition, (x,y)::Tuple{Int,Int})
function FindSet(P::Partition, tuple::Tuple{Int,Int})
    for set in P.Sets
        if tuple in set
            return sort(set)[1]
        end
    end
    return -1
end

# Funktion e) union!(P::Partition, (x1,y1)::Tuple{Int,Int}, (x2,y2)::Tuple{Int,Int})
function union!(P::Partition, tuple1::Tuple{Int,Int}, tuple2::Tuple{Int,Int})
    set1 = FindSet(P, tuple1)
    set2 = FindSet(P, tuple2)
    
    if set1 != -1 && set2 != -1
        sets_to_remove = []
        for (i, set) in enumerate(P.Sets)
            if set == set1 || set == set2
                push!(sets_to_remove, i)
            end
        end
        
        new_set = sort([tuple1, tuple2])
        for index in reverse(sets_to_remove)
            splice!(P.Sets, index)
        end
        push!(P.Sets, new_set)
    end
end

#=
S = TupleSet([(0,3),(0,1),(1,3),(1,0)]);
P = Partition(S);

println(union!(P,(1,3),(0,1)).Sets)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [ ( 0 , 3 ) ]
# [ ( 1 , 0 ) ]
# [ ( 0 , 1 ) , ( 1 , 3 ) ]
println(union!(P,(0,1),(0,3)).Sets)
# 2−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [ ( 1 , 0 ) ]
# [ ( 0 , 1 ) , ( 0 , 3 ) , ( 1 , 3 ) ]
println(FindSet(P,(0,3)))
# ( 0 , 1 )
println(MakeSet(P,(300,1)).Sets)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [ ( 1 , 0 ) ]
# [ ( 0 , 1 ) , ( 0 , 3 ) , ( 1 , 3 ) ]
# [ ( 3 0 0 , 1 ) ]
println(union!(P,(300,1),(0,1)).Sets)
# 2−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [ ( 1 , 0 ) ]
# [ ( 0 , 1 ) , ( 0 , 3 ) , ( 1 , 3 ) , ( 3 0 0 , 1 ) ]
=#


#= Input: [(1,3),(2,1)]
Erwarteter Output: [(1, 3), (2, 1), (457, 23), (457, 501), (342, 11), (110, 1), (110, 2)]
All Good
(110, 1)
=#

