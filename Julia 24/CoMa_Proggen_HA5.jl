mutable struct Node
    key::Int
    leftChild::Union{Node, Nothing}
    rightChild::Union{Node, Nothing}
    parent::Union{Node, Nothing}

    Node(key::Int) = new(key, nothing, nothing, nothing)
end

mutable struct AVLTree
    root::Node

    AVLTree(key::Int) = new(Node(key))
end

function insert!(avl::AVLTree, key::Int)
    new_node = Node(key)
    current = avl.root
    parent = nothing

    while current !== nothing
        parent = current
        if key < current.key
            current = current.leftChild
        else
            current = current.rightChild
        end
    end

    new_node.parent = parent

    if key < parent.key
        parent.leftChild = new_node
    else
        parent.rightChild = new_node
    end

    rebalance!(avl, new_node)
end

function height(node::Union{Node, Nothing})
    if node === nothing
        return -1
    else
        return 1 + max(height(node.leftChild), height(node.rightChild))
    end
end

function rotate_right(node::Node)
    new_root = node.leftChild
    node.leftChild = new_root.rightChild
    new_root.rightChild = node

    if node.leftChild !== nothing
        node.leftChild.parent = node
    end

    new_root.parent = node.parent

    if node.parent === nothing
        node.parent.root = new_root  # Assuming `node` is the root node of the AVLTree
    elseif node.key < node.parent.key
        node.parent.leftChild = new_root
    else
        node.parent.rightChild = new_root
    end

    node.parent = new_root
    return new_root
end

function rotate_left(node::Node)
    new_root = node.rightChild
    node.rightChild = new_root.leftChild
    new_root.leftChild = node

    if node.rightChild !== nothing
        node.rightChild.parent = node
    end

    new_root.parent = node.parent

    if node.parent === nothing
        node.parent.root = new_root  # Assuming `node` is the root node of the AVLTree
    elseif node.key < node.parent.key
        node.parent.leftChild = new_root
    else
        node.parent.rightChild = new_root
    end

    node.parent = new_root
    return new_root
end

function rotate_left_right(node::Node)
    node.leftChild = rotate_left(node.leftChild)
    return rotate_right(node)
end

function rotate_right_left(node::Node)
    node.rightChild = rotate_right(node.rightChild)
    return rotate_left(node)
end

function rebalance!(avl::AVLTree, node::Node)
    while node !== nothing
        if height(node.leftChild) >= 2 + height(node.rightChild)
            if height(node.leftChild.leftChild) >= height(node.leftChild.rightChild)
                node = rotate_right(node)
            else
                node = rotate_left_right(node)
            end
        elseif height(node.rightChild) >= 2 + height(node.leftChild)
            if height(node.rightChild.rightChild) >= height(node.rightChild.leftChild)
                node = rotate_left(node)
            else
                node = rotate_right_left(node)
            end
        end

        node = node.parent
    end
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