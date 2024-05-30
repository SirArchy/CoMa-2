mutable struct Node
    value::Union{Char,Nothing}
    freq::Int
    left::Union{Node,Nothing}
    right::Union{Node,Nothing}
end

function getFrequencies(text::String)::Dict{Char,Int}
    freqs = Dict{Char,Int}()
    for char in text
        if char in keys(freqs)
            freqs[char] += 1
        else
            freqs[char] = 1
        end
    end
    return freqs
end

function findLowestTwo(q1::Vector{Node}, q2::Vector{Node})::Tuple{Node, Node}
    combined = vcat(q1, q2)
    sort!(combined, by = x -> x.freq)
    return (combined[1], combined[2])
end

function huffman_tree(freqs::Dict{Char,Int})::Node
    q1 = [Node(char, freqs[char], nothing, nothing) for char in keys(freqs)]
    sort!(q1, by = x -> x.freq)
    q2 = Node[]
    
    while length(q1) + length(q2) > 1
        (a, b) = findLowestTwo(q1, q2)
        
        if a in q1
            deleteat!(q1, findfirst(isequal(a), q1))
        else
            deleteat!(q2, findfirst(isequal(a), q2))
        end
        
        if b in q1
            deleteat!(q1, findfirst(isequal(b), q1))
        else
            deleteat!(q2, findfirst(isequal(b), q2))
        end

        new_node = Node(nothing, a.freq + b.freq, a, b)
        push!(q2, new_node)
    end
    
    return q2[1]
end

function huffman_code(tree::Node)::Dict{Char, String}
    codes = Dict{Char, String}()

    function traverse(node::Node, path::String)
        if node.value !== nothing
            codes[node.value] = path
        else
            if node.left !== nothing
                traverse(node.left, path * "0")
            end
            if node.right !== nothing
                traverse(node.right, path * "1")
            end
        end
    end
    
    traverse(tree, "")
    return codes
end

function Encode(text::String, code::Dict{Char, String})::String
    encoded = ""
    for char in text
        encoded *= code[char]
    end
    return encoded
end

function Decode(encoded::String, tree::Node)::String
    decoded = ""
    node = tree
    for bit in encoded
        if bit == '0'
            node = node.left
        elseif bit == '1'
            node = node.right
        end
        if node.value !== nothing
            decoded *= node.value
            node = tree
        end
    end
    return decoded
end


# Beispielaufrufe
#Example = "Wenn der Physiker nicht weiter weiß, gründet er ein Arbeitskreis"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_code(hufftree)
#encoded = Encode(Example, huffcode)
#decoded = Decode(encoded, hufftree)

#Example = "Warum sind da Limetten bei den Tomaten?"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_code(hufftree)
#encoded = Encode(Example, huffcode)
#decoded = Decode(encoded, hufftree)


# Beispielaufrufe
#Example = "Wenn der Physiker nicht weiter weiß, gründet er ein Arbeitskreis"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_code(hufftree)
#encoded = Encode(Example, huffcode)
#decoded = Decode(encoded, hufftree)

#Example = "Warum sind da Limetten bei den Tomaten?"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_code(hufftree)
#encoded = Encode(Example, huffcode)
#decoded = Decode(encoded, hufftree)


#Die Abgabe war nicht erfolgreich. Das Programm hatte einen Laufzeitfehler.
#
#Fehler in den öffentlichen Testinstanzen:
#Es wurde für 2 von 8(25.0%) der Testinstanzen eine Lösung berechnet.
#Letzte versuchte Instanz:
#Input: Warum sind da Limetten bei den Tomaten?
#Erwarteter Output: Testing the Encode Function:
#111111101110011111110111100101001111110111101100111010011101110101111110111100100001100110001101011111000111101001110001101001111101111111100101110011000110111111111
#Fehler: UndefVarError