# Definition des Typs MaxHeap
struct MaxHeap
    keys::Vector{Int}
end

# Implementierung der Methoden

# Konstruktor
function MaxHeap(keys::Vector{Int})
    h = new()
    h.keys = keys
    n = length(keys)
    # Aufbau des Max-Heaps
    for i = div(n,2):-1:1
        maxHeapify(h,i)
    end
    return h
end

# maxHeapify - stellt die Max-Heap-Eigenschaft des Teilbaums mit Wurzelknoten i wieder her
function maxHeapify(h::MaxHeap, i::Int)
    n = length(h.keys)
    l = 2i # linker Kindknoten
    r = 2i+1 # rechter Kindknoten
    largest = i
    if l <= n && h.keys[l] > h.keys[i]
        largest = l
    end
    if r <= n && h.keys[r] > h.keys[largest]
        largest = r
    end
    if largest != i
        h.keys[i], h.keys[largest] = h.keys[largest], h.keys[i]
        maxHeapify(h,largest)
    end
end

# maximum - gibt das maximale Element des Max-Heaps zurück
function maximum(h::MaxHeap)
    return h.keys[1]
end

# extractMax - gibt das maximale Element des Max-Heaps zurück und stellt die Max-Heap-Eigenschaft wieder her
function extractMax(h::MaxHeap)
    n = length(h.keys)
    if n < 1
        error("Heap underflow")
    end
    max = h.keys[1]
    h.keys[1] = h.keys[n]
    deleteat!(h.keys,n)
    maxHeapify(h,1)
    return max
end

# increaseKey - erhöht den Eintrag von keys[i] auf k, falls k größer ist als keys[i], und stellt anschließend die Max-Heap-Eigenschaft wieder her
function increaseKey(h::MaxHeap, i::Int, k::Int)
    if k < h.keys[i]
        error("New key is smaller than current key")
    end
    h.keys[i] = k
    while i > 1 && h.keys[div(i,2)] < h.keys[i]
        h.keys[i], h.keys[div(i,2)] = h.keys[div(i,2)], h.keys[i]
        i = div(i,2)
    end
end

# insert - fügt ein Element mit dem Schlüssel k in keys ein und stellt anschließend die Max-Heap-Eigenschaft wieder her
function insert(h::MaxHeap, k::Int)
    push!(h.keys,k)
    n = length(h.keys)
    i = n
    while i > 1 && h.keys[div(i,2)] < h.keys[i]
        h.keys[i], h.keys[div(i,2)] = h.keys[div(i,2)], h.keys[i]
        i = div(i,2)
    end
end

# heapSort - führt Heapsort auf dem Max-Heap durch, so dass keys aufsteigend sortiert wird
function heapSort(h::MaxHeap)
    n = length(h.keys)
    for i = n:-1:2
        h.keys[1], h.keys[i] = h.keys[i], h.keys[1]
        n -= 1
        maxHeapify(h,1)
    end
end
