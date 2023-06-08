mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::AbstractString)::Union{Node, Nothing}
    stack = Vector{Node}()
    current_node = nothing
    current_number = ""
    is_left_child = true

    for char in str
        if char == '('
            if !isnothing(current_node)
                push!(stack, current_node)
            end
            current_node = Node(parse(Int, current_number), nothing, nothing, nothing)
            current_number = ""
            is_left_child = true
        elseif char == ','
            if is_left_child
                current_node.left = Node(parse(Int, current_number), nothing, nothing, current_node)
            else
                current_node.right = Node(parse(Int, current_number), nothing, nothing, current_node)
            end
            current_number = ""
            is_left_child = false
        elseif char == ')'
            if is_left_child
                current_node.left = Node(parse(Int, current_number), nothing, nothing, current_node)
            else
                current_node.right = Node(parse(Int, current_number), nothing, nothing, current_node)
            end
            if !isempty(stack)
                parent = pop!(stack)
                if is_left_child
                    parent.left = current_node
                else
                    parent.right = current_node
                end
                current_node = parent
            end
            current_number = ""
            is_left_child = false
        else
            current_number *= char
        end
    end

    if !isempty(stack)
        println("Der Baum ist kein Suchbaum!")
        return nothing
    end

    return current_node
end


println(fromString("4(1,5)"))
println(fromString("3(2(1,2),5(4,))"))
#=
Ausgabe: 
Node(4, Node(1, nothing, nothing, Node(4, nothing, nothing, nothing)), Node(5, nothing, nothing, Node(4, nothing, nothing, nothing)), nothing)
Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, nothing)), nothing)), nothing))
=#
#=
# Beispielaufrufe
tree2 = "3(2(1,2),5(4,))"
tree2 = fromString(tree2)
min2 = min(tree2)
println(min2)
println(getKeyList(tree2))
println(find(tree2, min2))

tree3 = "4(1,5)"
tree3 = fromString(tree3)
min3 = min(tree3)
println(min3)
println(getKeyList(tree3))
println(find(tree3, min3))
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