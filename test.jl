struct Node
    key::Int
    leftChild::Union{Node, Nothing}
    rightChild::Union{Node, Nothing}
end

# Modified constructor to use the struct directly
function Node(key::Int, leftChild::Union{Node, Nothing}=nothing, rightChild::Union{Node, Nothing}=nothing)
    Node(key, leftChild, rightChild)
end

# Modified keys function to use a stack
function keys(node::Node)
    # Stack for keeping track of nodes to visit
    stack = [node]
    # List to store the keys
    keyList = []
    
    # Loop until stack is empty
    while !isempty(stack)
        # Pop the top node from the stack
        currentNode = pop!(stack)
        
        # If node is not null, add its key to the key list
        if currentNode !== nothing
            push!(keyList, currentNode.key)
            # Add left and right children to the stack
            push!(stack, currentNode.leftChild)
            push!(stack, currentNode.rightChild)
        end
    end
    
    # Return the list of keys
    keyList
end

# Modified height function to use a stack
function height(node::Node)
    # Stack for keeping track of nodes and their heights
    stack = [(node, 0)]
    # Variable to keep track of the maximum height seen so far
    max_height = -1
    
    # Loop until stack is empty
    while !isempty(stack)
        # Pop the top node and its height from the stack
        currentNode, currentHeight = pop!(stack)
        
        # If node is not null, update the maximum height seen so far
        if currentNode !== nothing
            max_height = max(max_height, currentHeight)
            # Add left and right children to the stack with their corresponding heights
            push!(stack, (currentNode.leftChild, currentHeight + 1))
            push!(stack, (currentNode.rightChild, currentHeight + 1))
        end
    end
    
    # Return the maximum height seen so far
    max_height + 1
end

# Modified leaves function to use a stack
function leaves(node::Node)
    # Stack for keeping track of nodes to visit
    stack = [node]
    # List to store the keys of leaves
    leavesList = []
    
    # Loop until stack is empty
    while !isempty(stack)
        # Pop the top node from the stack
        currentNode = pop!(stack)
        
        # If node is not null, check if it is a leaf and add its key to the list
        if currentNode !== nothing
            if currentNode.leftChild === nothing && currentNode.rightChild === nothing
                push!(leavesList, currentNode.key)
            else
                # Add left and right children to the stack
                push!(stack, currentNode.leftChild)
                push!(stack, currentNode.rightChild)
            end
        end
    end
    
    # Return the list of keys of leaves
    leavesList
end


ex1 = Node(1)
ex2 = Node(2,Node(2,nothing,nothing),Node(2,nothing,Node(3)))

height(ex2)
#3
height(ex1)
#1
keys(ex1)
#1-element Vector{Any}:
#1
keys(ex2)
#4-element Vector{Any}:
#2
#2
#2
#3
leaves(ex2) 
#2
