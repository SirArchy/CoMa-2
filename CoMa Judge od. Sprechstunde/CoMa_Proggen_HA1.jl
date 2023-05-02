    struct Node
        key::Int
        leftChild::Union{Node, Nothing}
        rightChild::Union{Node, Nothing}
    end

    function Node(key::Int, leftChild::Union{Node, Nothing}=nothing, rightChild::Union{Node, Nothing}=nothing)
        new(key, leftChild, rightChild)
    end

    function keys(node::Node)
        # Verwenden eines Stacks, um den Baum zu durchlaufen
        stack = [node]
        result = []
        while !isempty(stack)
            node = pop!(stack)
            if node === nothing
                continue
            end
            # Fügt den Schlüssel des aktuellen Knotens der Ergebnisliste hinzu
            push!(result, node.key)
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            push!(stack, node.rightChild)
            push!(stack, node.leftChild)
        end
        # Gibt die Liste aller Schlüssel im Baum zurück
        result
    end

    function height(node::Node)
        # Verwenden eines Stacks, um den Baum zu durchlaufen und die Höhe zu berechnen
        stack = [(node, 0)]
        max_height = -1
        while !isempty(stack)
            node, height = pop!(stack)
            if node === nothing
                continue
            end
            # Aktualisiert die maximale Höhe, die bisher gesehen wurde
            max_height = max(max_height, height)
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            push!(stack, (node.rightChild, height+1))
            push!(stack, (node.leftChild, height+1))
        end
        # Gibt die Höhe des Baums zurück
        max_height + 1
    end

    function leaves(node::Node)
        # Verwenden eines Stacks, um den Baum zu durchlaufen
        stack = [node]
        result = []
        while !isempty(stack)
            node = pop!(stack)
            if node === nothing
                continue
            end
            # Fügt den Schlüssel des Knotens zur Ergebnisliste hinzu, wenn er ein Blatt ist
            if node.leftChild === nothing && node.rightChild === nothing
                push!(result, node.key)
            end
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            push!(stack, node.rightChild)
            push!(stack, node.leftChild)
        end
        # Gibt die Liste der Schlüssel der Blätter im Baum zurück
        result
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
