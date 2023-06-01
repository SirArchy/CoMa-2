struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function getKeyList(tree::Node)::Vector{Int}
    keys = Vector{Int}()
    _getKeyList(tree, keys)
    return keys
end

function _getKeyList(node::Node, keys::Vector{Int})
    if node == nothing
        return
    end
    _getKeyList(node.left, keys)
    push!(keys, node.key)
    _getKeyList(node.right, keys)
end

function find(node::Node, k::Int)::Union{Node, Nothing}
    if node == nothing || node.key == k
        return node
    elseif k < node.key
        return find(node.left, k)
    else
        return find(node.right, k)
    end
end

function min(node::Node)::Int
    while node.left != nothing
        node = node.left
    end
    return node.key
end

function fromString(str::String)::Node
    stack = Vector{Node}()
    current_node = nothing
    current_value = ""
    is_left_child = false
    
    for char in str
        if char == '('
            if current_value != ""
                key = parse(Int, current_value)
                new_node = Node(key, nothing, nothing, nothing)
                
                if isempty(stack)
                    current_node = new_node
                else
                    if is_left_child
                        stack[end].left = new_node
                    else
                        stack[end].right = new_node
                    end
                    new_node.parent = stack[end]
                    current_node = new_node
                end
                
                current_value = ""
            end
            
            push!(stack, current_node)
            is_left_child = true
        elseif char == ','
            if current_value != ""
                key = parse(Int, current_value)
                new_node = Node(key, nothing, nothing, nothing)
                
                if is_left_child
                    stack[end].left = new_node
                else
                    stack[end].right = new_node
                end
                new_node.parent = stack[end]
                current_node = new_node
                
                current_value = ""
                is_left_child = false
            end
        elseif char == ')'
            if current_value != ""
                key = parse(Int, current_value)
                new_node = Node(key, nothing, nothing, nothing)
                
                if is_left_child
                    stack[end].left = new_node
                else
                    stack[end].right = new_node
                end
                new_node.parent = stack[end]
                current_node = new_node
                
                current_value = ""
            end
            
            pop!(stack)
            if !isempty(stack)
                current_node = stack[end]
                is_left_child = false
            end
        else
            current_value *= char
        end
    end
    
    if current_value != ""
        key = parse(Int, current_value)
        new_node = Node(key, nothing, nothing, nothing)
        
        if is_left_child
            stack[end].left = new_node
        else
            stack[end].right = new_node
        end
        new_node.parent = stack[end]
        current_node = new_node
    end
    
    if current_node == nothing
        println("Der Baum ist kein Suchbaum!")
    end
    
    return current_node
end


#=
tree = 13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))|1
# Erwarteter Output: fromString() korrekt: true
# min: 13
# KeyList: [13, 52, 57, 57, 57, 57, 57, 57, 57, 58, 71]
# find the minimum: 13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))
# unable to find 0: true
# n_nodes: 11
=#