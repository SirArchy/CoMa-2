mutable struct Heap{T <: Real}
    data::Vector{T}
    comparator::Function

    # Inner constructor checking for comparator method and return type
    function Heap{T}(data::Vector{T}, comparator::Function) where T <: Real
        if !hasmethod(comparator, Tuple{T, T})
            throw(AssertionError("Comparator is not defined for arguments of type $T."))
        end

        if !all(rt -> rt <: Bool, Base.return_types(comparator, Tuple{T, T}))
            throw(AssertionError("Comparator does not return a Bool value."))
        end

        new{T}(data, comparator)
    end

    # Inner constructor with default comparator
    function Heap{T}(data::Vector{T}) where T <: Real
        new{T}(data, >=)
    end
end

# Outer constructor with default comparator
Heap(data::Vector{T}) where T <: Real = Heap{T}(data, >=)

# Outer constructor with a custom comparator
heap(data::Vector{T}, comparator::Function) where T <: Real = begin
    h = Heap{T}(data, comparator)
    heapify!(h)
end

function isHeap(heap::Heap{T}) where T <: Real
    for i in 2:length(heap.data)
        if !heap.comparator(heap.data[i ÷ 2], heap.data[i])
            return false
        end
    end
    return true
end

function siftDown!(heap::Heap{T}, i::Int, max::Int) where T
    while i * 2 <= max
        child = i * 2
        if child < max && !heap.comparator(heap.data[child], heap.data[child + 1])
            child += 1
        end
        if heap.comparator(heap.data[i], heap.data[child])
            return
        end
        heap.data[i], heap.data[child] = heap.data[child], heap.data[i]
        i = child
    end
end

function heapify!(heap::Heap{T}) where T <: Real
    for i in reverse(1:length(heap.data) ÷ 2)
        siftDown!(heap, i, length(heap.data))
    end
    heap
end

function heapSort!(heap::Heap{T}) where T <: Real
    heapify!(heap) # Ensure the heap property
    for max in reverse(1:length(heap.data))
        heap.data[1], heap.data[max] = heap.data[max], heap.data[1]
        siftDown!(heap, 1, max - 1)
    end
    # The heap is now sorted in increasing order
    reverse!(heap.data) # Return the heap data in normal order
    heap
end

function heapSort!(data::Vector{T}, comparator::Function) where T <: Real
    heap = heap(data, comparator) # Create a heap and heapify it
    heapSort!(heap) # Sort the heap
    heap.data # Return sorted data
end

function maximum(heap::Heap{T})::Union{T, Nothing} where T <: Real
    return isempty(heap.data) ? nothing : heap.data[1]
end

#=
Beispielcomparator(x,y) = x >= y
Beispielcomparator(1,2)

mutable struct IchBinEinStruct{T <:Real}
    field::T
    end
IchBinEinStruct{Int}(1)

is__Heap(Heap([1,2,3,4,5,6,7], comparator=(x,y)->x>=y))
is__Heap(Heap([1,2,3,4,5,6,7], comparator=(x,y)->x<=y))

heapify!(Heap([1,2,3,4,5,6,7], comparator=(x,y)->x>=y))
heapify!(Heap([1,2,3,4,5,6,7], comparator=(x,y)->x<=y))

heap([1,2,3,4,5,6,7], comparator=(x,y)->x>=y)

h1 = heap([1,2,3,4,5,6,7], comparator=(x,y)->x>=y)
heapSort!(h1)

heapSort!([1,7,3,5,6,4,2])

maximum(heap([1,7,3,5,6,4,2], comparator=(x,y)->x>=y))
=#