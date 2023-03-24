class Set:
    def __init__(self, V):
        self._elements = sorted(V) # Initialisiere das Attribut _elements als sortierte Liste von Tupeln

    def Elements(self):
        return self._elements # Gib die lexikographisch sortierte Liste _elements zurück


class Partition:
    def __init__(self, V):
        self.Sets = [] # Erzeuge eine leere Liste für Set-Objekte
        for (x, y) in V: # Iteriere durch jedes Tupel in V
            if (x, y) in [element for s in self.Sets for element in s._elements]: # Prüfe, ob das Tupel bereits in einem Set in Sets enthalten ist
                raise ValueError('invalid operation')
            self.Sets.append(Set([(x, y)])) # Füge ein neues Set-Objekt mit dem Tupel (x, y) als Element zu Sets hinzu

    def __str__(self):
        return str([s.Elements() for s in self.Sets]) # Gib eine Liste von _elements-Listen als String zurück

    def MakeSet(self, tup):
        if tup in [element for s in self.Sets for element in s._elements]: # Prüfe, ob das Tupel bereits in einem Set in Sets enthalten ist
            raise ValueError('invalid operation')
        self.Sets.append(Set([tup])) # Füge ein neues Set-Objekt mit dem Tupel als Element zu Sets hinzu

    def FindSet(self, tup):
        for s in self.Sets: # Iteriere durch jedes Set-Objekt in Sets
            if tup in s._elements: # Prüfe, ob das Tupel in diesem Set enthalten ist
                return s._elements[0] # Gib das Repräsentanten-Tupel zurück
        raise ValueError('invalid operation') # Wenn das Tupel nicht in Sets enthalten ist, werfe eine Exception

    def Union(self, tup1, tup2):
        s1, s2 = None, None
        for s in self.Sets: # Iteriere durch jedes Set-Objekt in Sets
            if tup1 in s._elements: # Prüfe, ob das Tupel tup1 in diesem Set enthalten ist
                s1 = s
            if tup2 in s._elements: # Prüfe, ob das Tupel tup2 in diesem Set enthalten ist
                s2 = s
            if s1 is not None and s2 is not None: # Wenn beide Sets gefunden wurden, beende die Schleife
                break
        if s1 is None or s2 is None: # Wenn eines der Sets nicht gefunden wurde, werfe eine Exception
            raise ValueError('invalid operation')
        new_set = Set(s1._elements + s2._elements) # Erzeuge ein neues Set-Objekt, das die Vereinigung von s1 und s2 ist
        self.Sets.remove(s1) # Entferne s1 aus Sets
        self.Sets.remove(s2) # Entferne s2 aus Sets
        self.Sets.append(new_set) # Füge new_set zu Sets hinzu



S = Set([(0,3),(0,1),(1,3),(1,0)])
print(S._elements) 
#[ ( 0 , 3) , ( 0 , 1) , ( 1 , 3) , ( 1 , 0) ] #✔
S.Elements()
#[ ( 0 , 1) , ( 0 , 3) , ( 1 , 0) , ( 1 , 3) ] #✔


S = Partition([(0,3),(0,1),(1,3),(1,0)])
S.Union((1,3),(0,1))
S.Union((0,3),(0,1))
print(S)
#[ [ ( 1 , 0) ] , [ ( 0 , 1) , ( 0 , 3) , ( 1 , 3) ] ] #✔
print(S.FindSet((1,3)))
#( 0 , 1) #✔
S.MakeSet((300,1))
S.Union((300,1),(0,1) )
print(S)
#[ [ ( 1 , 0) ] , [ ( 0 , 1) , ( 0 , 3) , ( 1 , 3) , (300 , 1) ] ] #✔
print(S.FindSet((300,1)))
#( 0 , 1) #✔
S.MakeSet((0,0))
S.Union((0,0),(0,1))
print(S.FindSet((300,1)))
#( 0 , 0) #✔
print(S) 
#[ [ ( 1 , 0) ] , [ ( 0 , 0) , ( 0 , 1) , ( 0 , 3) , ( 1 , 3) , (300 , 1) ] ] #✔