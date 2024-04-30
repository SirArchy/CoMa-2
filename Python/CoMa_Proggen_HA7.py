class ngonTriang:
    def __init__(self, n, triangles):
        if not all(all(isinstance(vertex, int) and 0 <= vertex < n for vertex in triangle) for triangle in triangles):
            raise ValueError("Invalid vertex indices")
        if n < 4 or not self._is_valid_triangles(n, triangles):
            raise ValueError("no triangulation")
        self.n = n
        self.triangles = sorted([sorted(triangle) for triangle in triangles])
        self.walls = self._calculate_walls()

    def _is_valid_triangles(self, n, triangles):
        expected_triangles_count = n - 2
        if len(triangles) != expected_triangles_count:
            return False

        walls = {}
        for triangle in triangles:
            for i in range(3):
                wall = tuple(sorted((triangle[i], triangle[(i + 1) % 3])))
                if wall not in walls:
                    walls[wall] = 0
                walls[wall] += 1
        
        for wall, count in walls.items():
            # Jede Seite darf entweder einmal (Rand der Figur) oder zweimal (innen) vorkommen.
            if count > 2 or count < 1:
                return False
        return True
    
    def _is_triangulation(self):
        wall_counts = {}
        for triangle in self.triangles:
            for i in range(3):
                wall = tuple(sorted((triangle[i], triangle[(i + 1) % 3])))
                wall_counts[wall] = wall_counts.get(wall, 0) + 1
        
        for wall, count in wall_counts.items():
            # Randkanten dürfen nur einmal vorkommen, alle anderen genau zweimal.
            if (count != 2 and wall[0] != 0 and wall[1] != 0) or count > 2:
                return False
        return True
    
    def _calculate_walls(self):
        walls = set()
        for triangle in self.triangles:
            for i in range(3):
                wall = tuple(sorted((triangle[i], triangle[(i + 1) % 3])))
                if wall in walls:
                    walls.remove(wall)
                else:
                    walls.add(wall)
        return sorted(list(walls))
    
    def n_walls(self):
        return len(self.walls)
    
    def flip(self, wall):
        if wall not in self.walls:
            raise ValueError("Wall does not exist")
        
        adjacent_triangles = [triangle for triangle in self.triangles if set(wall).issubset(set(triangle))]
        if len(adjacent_triangles) != 2:
            raise ValueError("Cannot flip an edge on the polygon boundary or non-shared edge")
        
        quad = set(adjacent_triangles[0]) | set(adjacent_triangles[1])
        alternative_diag = list(quad - set(wall))
        
        new_triangles = [triangle for triangle in self.triangles if set(wall).isdisjoint(set(triangle))]
        new_triangles.append(sorted([wall[0], *alternative_diag]))
        new_triangles.append(sorted([wall[1], *alternative_diag]))

        return ngonTriang(self.n, new_triangles)

# Beispielaufrufe
n = 4
triangles = [[0, 1, 2], [0, 2, 3]]
T = ngonTriang(n, triangles)

# Zugriff auf die Attribute und Methoden der Instanz T
print(T.triangles)
print(T.walls)
print(T.n_walls())

## Durchführen eines Flips und Ausgabe der neuen Triangulierung
#S = T.flip([0, 2])
#print(S.triangles)
#
## Versuch, eine ungültige Triangulierung zu erstellen
#try:
#    W = ngonTriang(n, [[0, 1, 2], [0, 2, 3], [1, 2, 3]])
#except ValueError as e:
#    print(e)