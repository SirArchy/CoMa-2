class ngonTriang:
    def __init__(self, n, triangles):
        if not self._is_triangulation(triangles):
            raise ValueError("no triangulation")
        self.n = n
        self.triangles = sorted(triangles)
        self.walls = self._calculate_walls()
    
    def _is_triangulation(self, triangles):
        # Eine einfache Implementierung könnte überprüfen,
        # ob die Anzahl der Dreiecke gleich n-2 ist und ob
        # die Dreiecke die angegebenen Bedingungen erfüllen.
        return len(triangles) == (self.n - 2)
    
    def _calculate_walls(self):
        walls = set()
        for triangle in self.triangles:
            # Sortieren Sie die Ecken des Dreiecks, um konsistente Wand-Paare zu gewährleisten
            edges = [sorted((triangle[i], triangle[(i+1) % 3])) for i in range(3)]
            for edge in edges:
                if edge in walls:
                    walls.remove(edge)
                else:
                    walls.add(tuple(edge))
        return sorted(list(walls))
    
    def n_walls(self):
        return len(self.walls)
    
    def flip(self, wall):
        if wall not in self.walls:
            raise ValueError("Wall does not exist")
        
        # Finden der beiden Dreiecke, die an der Wand anliegen
        adjacent_triangles = [t for t in self.triangles if set(wall).issubset(t)]
        # Berechnen Sie das Viereck aus beiden Dreiecken und entfernen Sie die Wand
        quad = set(adjacent_triangles[0]) | set(adjacent_triangles[1]) - set(wall)
        # Bestimmung der alternativen Diagonale
        alternative_diag = sorted(list(quad - set(wall)))
        
        # Erstellen der neuen Dreiecke mit der alternativen Diagonale
        new_triangles = [t for t in self.triangles if set(wall).isdisjoint(t)]
        new_triangles += [sorted(list(set(adjacent_triangles[0]) - set(wall) | set(alternative_diag[:1]))),
                          sorted(list(set(adjacent_triangles[1]) - set(wall) | set(alternative_diag[1:])))]
        
        return ngonTriang(self.n, new_triangles)

# Beispielaufrufe
n = 4
triangles = [[0, 1, 2], [0, 2, 3]]
T = ngonTriang(n, triangles)

# Zugriff auf die Attribute und Methoden der Instanz T
print(T.triangles)
print(T.walls)
print(T.n_walls())

# Durchführen eines Flips und Ausgabe der neuen Triangulierung
S = T.flip([0, 2])
print(S.triangles)

# Versuch, eine ungültige Triangulierung zu erstellen
try:
    W = ngonTriang(n, [[0, 1, 2], [0, 2, 3], [1, 2, 3]])
except ValueError as e:
    print(e)