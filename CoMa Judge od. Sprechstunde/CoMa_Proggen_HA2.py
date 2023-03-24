class MaxHeap:
    def __init__(self, keys):
        # Erstelle den Heap aus der übergebenen Liste keys.
        self.keys = keys
        n = len(keys)
        # Wende maxHeapify auf jeden Knoten an, der mindestens ein Kind hat.
        for i in range(n//2, -1, -1):
            self.maxHeapify(i, n)
            
    def maxHeapify(self, i, n):
        # Stellt die Max-Heap-Eigenschaft von Knoten i wieder her.
        left = 2*i + 1
        right = 2*i + 2
        largest = i
        # Überprüfe, ob das linke Kind größer als der aktuelle Knoten ist.
        if left < n and self.keys[left] > self.keys[largest]:
            largest = left
        # Überprüfe, ob das rechte Kind größer als der aktuelle Knoten oder das linke Kind ist.
        if right < n and self.keys[right] > self.keys[largest]:
            largest = right
        # Wenn largest != i, tausche die Positionen von i und largest und rufe maxHeapify auf largest auf.
        if largest != i:
            self.keys[i], self.keys[largest] = self.keys[largest], self.keys[i]
            self.maxHeapify(largest, n)
    
    def maximum(self):
        # Das größte Element ist das erste Element in der Liste, da es sich um einen Max-Heap handelt.
        return self.keys[0]
    
    def extractMax(self):
        # Falls der Heap leer ist, gibt es None zurück.
        if len(self.keys) < 1:
            return None
        # Das größte Element ist das erste Element in der Liste.
        max_key = self.keys[0]
        # Ersetze das erste Element mit dem letzten Element in der Liste und entferne das letzte Element.
        self.keys[0] = self.keys[-1]
        self.keys.pop()
        # Stelle die Max-Heap-Eigenschaft wieder her, indem es maxHeapify auf Knoten 0 anwendet.
        self.maxHeapify(0, len(self.keys))
        # Gib das entfernte maximale Element zurück.
        return max_key
    
    def increaseKey(self, i, k):
        # Wenn k kleiner als der aktuelle Schlüssel an Position i ist, kann der Schlüssel nicht erhöht werden.
        if k < self.keys[i]:
            return 'k too small'
        # Andernfalls ersetze den Schlüssel an Position i mit k.
        self.keys[i] = k
        # Führe einen Tausch mit dem Elternteil aus, bis der Elternteil größer als der aktuelle Knoten ist oder der Knoten an der Wurzel angekommen ist.
        while i > 0 and self.keys[(i-1)//2] < self.keys[i]:
            self.keys[(i-1)//2], self.keys[i] = self.keys[i], self.keys[(i-1)//2]
            i = (i-1)//2
    
    def insert(self, k):
        # Füge das Element k am Ende der Liste hinzu.
        self.keys.append(k)
        i = len(self.keys) - 1
        # Führe einen Tausch mit dem Elternteil aus, bis der Elternteil größer als der aktuelle Knoten ist oder der Knoten an der Wur
