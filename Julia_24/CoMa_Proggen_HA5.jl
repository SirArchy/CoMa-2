# Definieren des Node-structs
struct Node
    value::Union{Char,Nothing}
    freq::Int
    left::Union{Node,Nothing}
    right::Union{Node,Nothing}
end

# Implementierung der Funktion, um die Häufigkeiten zu ermitteln
function getFrequencies(text::String)::Dict{Char,Int}
    freqs = Dict{Char,Int}()
    for char in text
        if haskey(freqs, char)
            freqs[char] += 1
        else
            freqs[char] = 1
        end
    end
    return freqs
end

# Implementierung der Funktion findLowestTwo
function findLowestTwo(q1::Vector{Node}, q2::Vector{Node})::Tuple{Node, Node}
    node1 = popfirst!(q1)
    node2 = isempty(q2) ? popfirst!(q1) : popfirst!(q2)
    
    if isempty(q1) && !isempty(q2) && node2.freq < node1.freq
        return (node2, node1)
    end
    return (node1, node2)
end

# Implementierung der Funktion, um den Huffman-Baum zu erzeugen
function huffman_tree(freqs::Dict{Char,Int})::Node
    q1 = [Node(char, freq, nothing, nothing) for (char, freq) in sort(collect(freqs), by=x->x[2])]
    q2 = Vector{Node}()
    while length(q1) + length(q2) > 1
        node1, node2 = findLowestTwo(q1, q2)
        combined_node = Node(nothing, node1.freq + node2.freq, node1, node2)
        push!(q2, combined_node)
    end
    return isempty(q1) ? popfirst!(q2) : popfirst!(q1)
end

# Helper function to recursively build Huffman Code map
function build_huffman_code(node::Node, code::String, code_map::Dict{Char, String})
    if node.value !== nothing
        code_map[node.value] = code
    else
        if node.left !== nothing
            build_huffman_code(node.left, code * "0", code_map)
        end
        if node.right !== nothing
            build_huffman_code(node.right, code * "1", code_map)
        end
    end
end

# Hilfsfunktion, um das Huffman-Codebuch zu erstellen
function huffman_codebook(tree::Node)::Dict{Char, String}
    code_map = Dict{Char, String}()
    build_huffman_code(tree, "", code_map)
    return code_map
end

# Implementierung der Funktion Encode
function Encode(text::String, code::Dict{Char, String})::String
    encoded = String[]
    for char in text
        push!(encoded, code[char])
    end
    return join(encoded)
end

# Implementierung der Funktion Decode
function Decode(encoded::String, tree::Node)::String
    decoded_chars = Char[] 
    current = tree        
    for bit in encoded
        if bit == '0'
            current = current.left
        else
            current = current.right
        end
        if current.value !== nothing
            push!(decoded_chars, current.value) 
            current = tree  
        end
    end
    return join(decoded_chars) 
end

# Beispielaufrufe
#Example = "Wenn der Physiker nicht weiter weiß, gründet er ein Arbeitskreis"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_codebook(hufftree)
#encoded = Encode(Example, huffcode)
#decoded = Decode(encoded, hufftree)

#Example = "Warum sind da Limetten bei den Tomaten?"
#freqs = getFrequencies(Example)
#hufftree = huffman_tree(freqs)
#huffcode = huffman_codebook(hufftree)
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