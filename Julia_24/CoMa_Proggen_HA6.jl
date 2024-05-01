struct IntVektor
    x::Int
    y::Int
    z::Int
end

Base.:+(v1::IntVektor, v2::IntVektor) = IntVektor(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

Base.:*(v::IntVektor, scalar::Int) = IntVektor(v.x * scalar, v.y * scalar, v.z * scalar)
Base.:*(scalar::Int, v::IntVektor) = v * scalar

function copy(v::IntVektor)
    return IntVektor(v.x, v.y, v.z)
end

Base.show(io::IO, v::IntVektor) = print(io, "(", v.x, ", ", v.y, ", ", v.z, ")")

mutable struct Teilgitter <: IntVektor
    koordinate_1::Int
    koordinate_2::Int
end

function Teilgitter(x::Int, y::Int, z::Int)
    b1 = IntVektor(2, 1, 15)
    b2 = IntVektor(1, 0, 5)
    
    k1, k2 = calculate_coordinates(x, y, z, b1, b2)
    
    if k1 === nothing || k2 === nothing
        error("Vektor liegt nicht im Teilgitter.")
    end
    
    new_teilgitter = new(x, y, z)
    new_teilgitter.koordinate_1 = k1
    new_teilgitter.koordinate_2 = k2
    return new_teilgitter
end

function calculate_coordinates(x, y, z, b1, b2)
    if z % b2.z !== 0
        return nothing, nothing
    end
    
    k2 = div(z, b2.z)
    adjusted_x = x - k2
    adjusted_y = y
    
    if adjusted_x % b1.x !== 0 || adjusted_y % b1.y !== 0
        return nothing, nothing
    end
    
    k1 = div(adjusted_x, b1.x)
    
    if b1.z * k1 + b2.z * k2 == z
        return k1, k2
    else
        return nothing, nothing
    end
end

Base.show(io::IO, g::Teilgitter) = print(io, "(", g.x, ", ", g.y, ", ", g.z, "); Koordinate 1: ", g.koordinate_1, ", Koordinate 2: ", g.koordinate_2)

Base.:+(g1::Teilgitter, g2::Teilgitter) = Teilgitter(g1.x + g2.x, g1.y + g2.y, g1.z + g2.z)

Base.:*(g::Teilgitter, scalar::Int) = Teilgitter(scalar * g.x, scalar * g.y, scalar * g.z)
Base.:*(scalar::Int, g::Teilgitter) = g * scalar

#=
# Example usage
A = Teilgitter(10, 3, 23)
println(A)

B = Teilgitter(14, 4, 34)
println(B)

C = A + B
println(C)

D = 3 * A
println(D)

E = -3 * A
println(E)

F = B * 7
println(F)

# The product A * B doesn't make sense in this context because we don't have a definition for multiplying two Teilgitter objects. We would need additional information about what this operation represents.

G = copy(A)
println(G)

H = Teilgitter(9, 5, 25)
println(H)


# Beispielaufrufe

str = "58(49(89,),93(80,))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "4(1,5)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "3(2(1,2),5(4,))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "9(,97)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))
#=
Ausgabe: 
Node(4, Node(1, nothing, nothing, Node(4, nothing, nothing, nothing)), Node(5, nothing, nothing, Node(4, nothing, nothing, nothing)), nothing)
Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, nothing)), nothing)), nothing))
=#



# Beispielaufrufe
tree1 = "13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))"
tree1 = fromString(tree1)
min1 = min(tree1)
println(min1)
println(getKeyList(tree1))
println(find(tree1, min1))
# Erwarteter Output: 
# fromString() korrekt: true
# min: 13
# KeyList: [13, 52, 57, 57, 57, 57, 57, 57, 57, 58, 71]
# find the minimum: 13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))
# unable to find 0: true
# n_nodes: 11
=#