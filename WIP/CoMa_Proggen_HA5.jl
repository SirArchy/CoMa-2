# Definition des Types FactorTree
struct FactorTree
    value::Int
    left::Union{Int, FactorTree}
    right::Union{Int, FactorTree}
end

# Konstruktor für den FactorTree-Typ
function FactorTree(v::Int) #✅
    return FactorTree(v, 0, 0)
end

# Hilfsfunktion zur Berechnung der Primfaktorzerlegung
function primeFactors(n::Int) #✅
    factors = Dict{Int, Int}()
    d = 2
    while d * d <= n
        if n % d == 0
            count = 0
            while n % d == 0
                n = div(n, d)
                count += 1
            end
            factors[d] = count
        end
        d += 1
    end
    if n > 1
        factors[n] = 1
    end
    return factors
end

# Funktion zur Berechnung der Primfaktorzerlegung des Wurzelknotens eines Zerlegungsbaums
function getFactors(t::FactorTree) #✅
    return primeFactors(t.value)
end

# Funktion zur Berechnung der Struktur des Zerlegungsbaums als String
function getShape(t::FactorTree)
    if isa(t.left, Int) && isa(t.right, Int)
        return "p"
    elseif isa(t.left, FactorTree) && isa(t.right, Int)
        return "f(p|p2)"
    elseif isa(t.left, Int) && isa(t.right, FactorTree)
        return "f(p2|p)"
    else
        return "f(p|p)"
    end
end

# Funktion zum Vergleichen zweier Zerlegungsbäume auf gleiche Struktur
function compareShape(t::FactorTree, h::FactorTree)
    return getShape(t) == getShape(h)
end

# Funktion zur Berechnung aller Zerlegungsstrukturen von Zahlen kleiner als n
function computeShapes(n::Int)
    shapes = Dict{String, Vector{Int}}()
    for i in 1:n
        t = FactorTree(i)
        shape = getShape(t)
        if haskey(shapes, shape)
            push!(shapes[shape], i)
        else
            shapes[shape] = [i]
        end
    end
    return shapes
end



#✅
#❌
# Beispielverwendung
t1 = FactorTree(20)
t2 = FactorTree(945)
t4 = FactorTree(72)
t5 = FactorTree(6375)
t6 = FactorTree(216)
t7 = FactorTree(112)

#=
#(945, 2205, 2835, 112) 
#(2396, 4852, 7188, 2024)
#(8909, 6411, 26727, 2625)
println(getShape(t1))
println(getShape(t2))
println(compareShape(t1, t2))
println(getShape(t1))
println(getShape(t4))
println(compareShape(t1, t4))
println(compareShape(t4, t2))
println(compareShape(t4, t6))
println(compareShape(t5, t7))
println(compareShape(t4, t7))
=#
println(computeShapes(20))
println(computeShapes(945))
println(computeShapes(72))
println(computeShapes(6375))
println(computeShapes(216))
println(computeShapes(112))

println(t1)
println(t2)
println(t4)
println(t5)
println(t6)
println(t7)


#=
Zusammenfassung:
Test Summary:                       | Pass  Fail  Total
PA05                                |   36     8     44
  input = (72, 6375, 216, 112)      |    9     2     11
    Zerlegungsbaum                  |    9     2     11  1.0s
      Primfaktorzerlegung           |    3            3  0.0s
      getShape                      |    2            2  0.0s
      compareShape                  |    2     1      3  0.9s
      computeShapes                 |    2     1      3  0.1s
  input = (945, 2205, 2835, 112)    |    9     2     11
    Zerlegungsbaum                  |    9     2     11  0.0s
      Primfaktorzerlegung           |    3            3  0.0s
      getShape                      |    2            2  0.0s
      compareShape                  |    2     1      3  0.0s
      computeShapes                 |    2     1      3  0.0s
  input = (2396, 4852, 7188, 2024)  |    9     2     11
    Zerlegungsbaum                  |    9     2     11  0.0s
      Primfaktorzerlegung           |    3            3  0.0s
      getShape                      |    2            2  0.0s
      compareShape                  |    2     1      3  0.0s
      computeShapes                 |    2     1      3  0.0s
  input = (8909, 6411, 26727, 2625) |    9     2     11
    Zerlegungsbaum                  |    9     2     11  0.0s
      Primfaktorzerlegung           |    3            3  0.0s
      getShape                      |    2            2  0.0s
      compareShape                  |    2     1      3  0.0s
      computeShapes                 |    2     1      3  0.0s
=#