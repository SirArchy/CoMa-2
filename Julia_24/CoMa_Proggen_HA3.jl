# Mutable struct für den binären Heap
mutable struct Heap{T <: Real}
    data::Vector{T}
    comparator::Function  # Ein Vergleichsoperator

    # Innerer Konstruktor mit comparator, überprüft ob comparator richtig definiert ist
    function Heap(data::Vector{T}, comparator::Function) where T <: Real
        if !hasmethod(comparator, Tuple{T, T}) || !issubtype(Bool, eltype(Base.return_types(comparator, Tuple{T, T})))
            throw(AssertionError("Der comparator muss für den Typ T definiert sein und einen Bool zurückgeben"))
        end

        new{T}(data, comparator)
    end

    # Innerer Konstruktor ohne spezifischen comparator, verwendet >= als Standard
    function Heap(data::Vector{T}) where T <: Real
        new{T}(data, >=)
    end
end

# Funktion, die prüft, ob der Heap die Heapbedingung erfüllt
function is__Heap(heap::Heap{T})::Bool where T <: Real
    n = length(heap.data)
    for i in 1:n
        parentIndex = i ÷ 2
        if parentIndex > 0 && !heap.comparator(heap.data[parentIndex], heap.data[i])
            return false
        end
    end
    true
end

# Hilfsfunktion für heapify!
function downHeap!(heap::Heap{T}, index::Int) where T
    n = length(heap.data)
    while true
        left = index * 2
        right = left + 1
        largest = index

        if left ≤ n && !heap.comparator(heap.data[largest], heap.data[left])
            largest = left
        end
        if right ≤ n && !heap.comparator(heap.data[largest], heap.data[right])
            largest = right
        end

        if largest != index
            heap.data[index], heap.data[largest] = heap.data[largest], heap.data[index]
            index = largest
        else
            break
        end
    end
end

# Funktion, die den Heap so umsortiert, dass die Heapbedingung erfüllt ist
function heapify!(heap::Heap{T})::Heap{T} where T <: Real
    n = length(heap.data)
    for i in n ÷ 2:-1:1
        downHeap!(heap, i)
    end
    heap
end

# Äußerer Konstruktor für den Typ Heap
function heap(data::Vector{T}; comparator::Function = >=)::Heap{T} where T <: Real
    h = Heap(data; comparator=comparator)
    heapify!(h)
end

# Funktion zum Sortieren des Heaps in aufsteigender Reihenfolge
function heapSort!(heap::Heap{T})::Vector{T} where T <: Real
    heapify!(heap)
    n = length(heap.data)
    for i in n:-1:2
        heap.data[1], heap.data[i] = heap.data[i], heap.data[1]
        tmpHeap = Heap{T}(heap.data[1:i-1], heap.comparator)
        downHeap!(tmpHeap, 1)
        heap.data[1:i-1] = tmpHeap.data
    end
    heap.data
end

# Funktion für das Sortieren eines Datenvektors unter Verwendung eines Heaps
function heapSort!(data::Vector{T}; comparator::Function)::Vector{T} where T <: Real
    h = heap(data; comparator=comparator)
    heapSort!(h)
end

# Funktion, die das Maximum eines Heaps zurückgibt
function maximum(heap::Heap{T})::Union{T, Nothing} where T <: Real
    return isempty(heap.data) ? nothing : heap.data[1]
end