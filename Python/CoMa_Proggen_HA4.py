class Set:
    def __init__(self, V):
        self._elements = V

    def elements(self):
        return sorted(self._elements)


class Partition:
    def __init__(self, V):
        self.Sets = []
        elements_check_set = set()
        for tup in V:
            if tup in elements_check_set:
                raise Exception('invalid operation')
            elements_check_set.add(tup)
            self.Sets.append(Set([tup]))

    def __str__(self):
        return str([s.elements() for s in self.Sets])

    def MakeSet(self, xy):
        if any(xy in s.elements() for s in self.Sets):
            raise Exception('invalid operation')
        self.Sets.append(Set([xy]))

    def FindSet(self, xy):
        for s in self.Sets:
            if xy in s.elements():
                return s.elements()[0]
        raise Exception('invalid operation')

    def Union(self, xy1, xy2):
        s1 = s2 = None
        for s in self.Sets:
            if xy1 in s.elements():
                s1 = s
            elif xy2 in s.elements():
                s2 = s
        if s1 is None or s2 is None:
            raise Exception('invalid operation')
        new_set_elements = s1.elements() + s2.elements()
        new_set_elements.sort()
        self.Sets.remove(s1)
        self.Sets.remove(s2)
        self.Sets.append(Set(new_set_elements))




# Beispielaufruf
S = Set([(0, 3), (0, 1), (1, 3), (1, 0)])
print(S.elements())  # [(0, 1), (0, 3), (1, 0), (1, 3)]

# Beispielaufrufe
S = Partition([(0, 3), (0, 1), (1, 3), (1, 0)])
S.Union((1, 3), (0, 1))
S.Union((0, 3), (0, 1))
print(S)  # [[(1, 0)], [(0, 1), (0, 3), (1, 3)]]
print(S.FindSet((1, 3)))  # (0, 1)
S.MakeSet((300, 1))
S.Union((300, 1), (0, 1))
print(S)  # [[(1, 0)], [(0, 1), (0, 3), (1, 3), (300, 1)]]
print(S.FindSet((300, 1)))  # (0, 1)
S.MakeSet((0, 0))
S.Union((0, 0), (0, 1))
print(S.FindSet((300, 1)))  # (0, 0)
print(S)  # [[(1, 0)], [(0, 0), (0, 1), (0, 3), (1, 3), (300, 1)]]