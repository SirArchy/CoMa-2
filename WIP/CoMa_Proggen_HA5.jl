# Definition des Types FactorTree
struct FactorTree
    value::Int
    left::Union{Int, FactorTree}
    right::Union{Int, FactorTree}
end

# Konstruktor für den FactorTree-Typ
function FactorTree(v::Int)
    return FactorTree(v, 0, 0)
end

# Hilfsfunktion zur Berechnung der Primfaktorzerlegung
function primeFactors(n::Int)
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
function getFactors(t::FactorTree)
    return primeFactors(t.value)
end

# Funktion zur Rückgabe der Struktur des Zerlegungsbaums als String
function getShape(t::FactorTree)
    if t.left == 0 && t.right == 0
        return "p"
    elseif t.left isa Int && t.right isa Int
        return "p2"
    else
        return "f(" * getShape(t.left) * "|" * getShape(t.right) * ")"
    end
end

# Funktion zum Vergleichen der Strukturen von zwei Zerlegungsbäumen
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

#=
# Beispielverwendung
t = FactorTree(20)
println(getFactors(t))
println(getShape(t))

t2 = FactorTree(945)
t3 = FactorTree(72)
println(compareShape(t2, t3))

println(computeShapes(10))



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