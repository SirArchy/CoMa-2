# Type TupleSet 
struct TupleSet
    const TupleSet = Vector{Tuple{Int, Int}}
    function TupleSet(name::String)
        new(TupleSet(V::Vector{Tuple{Int, Int}}) = sort(V))
    end
end

# Type Partition
struct Partition
    Sets::Vector{TupleSet}
end

# Function Partition
function Partition(V::TupleSet)
    return new(Partition(V))
end

# Function MakeSet
function MakeSet(P::Partition, (x,y)::Tuple{Int,Int}) 
    return
end

# Function FindSet
function FindSet(P::Partition, (x,y)::Tuple{Int,Int}) 
    return
end

# Function union!
function union!(P::Partition, (x1,y1)::TupleInt,Int, (x2,y2)::TupleInt,Int) 
    return
end


S = TupleSet([(0,3),(0,1),(1,3),(1,0)])
P = Partition(S)

println(union!(P,(1,3),(0,1)).Set)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(0,3)]
# [(1,0)]
# [(0,1),(1,3)]
println(union!(P,(0,1),(0,3)).Set)
# 2−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(1,0)]
# [(0,1),(0,3),(1,3)]
println(FindSet(P,(0,3)))
# (0,1)
println(MakeSet(P,(300,1)).Set)
# 3−element Vector {Vector {Tuple { Int64 , Int64 }}} :
# [(1,0)]
# [(0,1),(0,3),(1,3)]
# [(300,1)]
println(union!(P,(300,1),(0,1)).Set)
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

