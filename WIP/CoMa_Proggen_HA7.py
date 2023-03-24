class ngonTriang:
    def __init__(self, n, triangles):
        # Überprüfe, ob die Eingabe eine gültige Triangulierung beschreibt
        if not self._is_triangulation(triangles, n):
            raise ValueError("no triangulation")
        # Initialisiere Attribute
        self.n = n
        # Sortiere Dreiecke lexikographisch aufsteigend und entferne Duplikate
        self.triangles = sorted([tuple(sorted(tri)) for tri in triangles])
        # Berechne die Kanten der Triangulierung
        self.walls = self._compute_walls()
        
    def n_walls(self):
        # Gebe die Anzahl der Kanten zurück
        return len(self.walls)
    
    def flip(self, wall):
        # Kopiere die Liste der Dreiecke
        new_triangles = self.triangles.copy()
        # Bestimme die beiden Dreiecke, die durch die gegebene Kante verbunden sind
        t1, t2 = self.walls[wall]
        # Entferne die beiden Dreiecke aus der Liste
        new_triangles.remove(t1)
        new_triangles.remove(t2)
        # Bestimme die beiden Dreiecke, die entstehen, wenn man den Flip durchführt
        new_triangles.append(tuple(sorted(set(t1) - set(self.walls[wall]))))
        new_triangles.append(tuple(sorted(set(t2) - set(self.walls[wall]))))
        # Erstelle ein neues ngonTriang-Objekt mit den neuen Dreiecken
        return ngonTriang(self.n, new_triangles)
    
    def _compute_walls(self):
        # Bestimme alle Kanten der Triangulierung
        walls = []
        for i in range(len(self.triangles)):
            for j in range(i+1, len(self.triangles)):
                common = set(self.triangles[i]) & set(self.triangles[j])
                if len(common) == 2:
                    walls.append(tuple(sorted(common)))
        # Sortiere Kanten lexikographisch aufsteigend und entferne Duplikate
        return sorted(walls)
    
    def _is_triangulation(self, triangles, n):
        # Überprüfe, ob die gegebenen Dreiecke eine gültige Triangulierung beschreiben
        # Überprüfe, ob die Eckpunkte von 0 bis n-1 nummeriert sind
        for tri in triangles:
            if max(tri) >= n or min(tri) < 0:
                return False
        # Überprüfe, ob jede Kante genau einem Dreieck gehört
        edges = set()
        for tri in triangles:
            for i in range(3):
                edge = tuple(sorted([tri[i], tri[(i+1)%3]]))
                if edge in edges:
                    return False
                else:
                    edges.add(edge)
        # Überprüfe, ob die Dreiecke eine zusammenhängende Region bilden
        visited = set()
        stack = [0]
        while stack:
            v = stack.pop()
            visited.add(v)
            for tri in triangles:
                if v in tri:
                    for w in tri:
                        if w != v and w not in visited:
                            stack.append(w)
        if visited != set(range(n)):
            return False
        return True


n=4
triangles = [[0,1,2],[0,2,3]]
T = ngonTriang(n,triangles)
T.triangles
#[ [ 0 , 1 , 2 ] , [ 0 , 2 , 3 ] ]
T.walls
#[ [ 0 , 2 ] ]
T.n_walls()
#1
S = T.flip([0,2])
S.triangles
#[ [ 0 , 1 , 3 ] , [ 1 , 2 , 3 ] ]
W = ngonTriang(n,[[0,1,2],[0,2,3],[1,2,3]])
#ValueError : no t r i a n g u l a t i o n



#✔
#❌