class Teilgitter(IntVektor):

    def __init__(self, x, y, z):
        super().__init__(x, y, z)
        if z != 2*x + 5*y:
            raise ValueError("Vektor liegt nicht im Teilgitter.")
        self.Koordinate_1 = x
        self.Koordinate_2 = y

    def __str__(self):
        return super().__str__() + "; Koordinate 1: {0}, Koordinate 2: {1}".format(self.Koordinate_1, self.Koordinate_2)

    def __add__(self, other):
        if isinstance(other, Teilgitter):
            return Teilgitter(self.x + other.x, self.y + other.y, self.z + other.z)
        else:
            raise TypeError("Formate passen nicht.")

    def __mul__(self, other):
        if isinstance(other, Teilgitter):
            return Teilgitter(self.x * other.x, self.y * other.y, self.z * other.z)
        elif type(other) == int:
            return Teilgitter(self.x * other, self.y * other, self.z * other)
        else:
            raise TypeError("Formate passen nicht.")

    def __rmul__(self, other):
        if isinstance(other, Teilgitter):
            return Teilgitter(self.x * other.x, self.y * other.y, self.z * other.z)
        elif type(other) == int:
            return Teilgitter(self.x * other, self.y * other, self.z * other)
        else:
            raise TypeError("Formate passen nicht.")

    def copy(self):
        return Teilgitter(self.x, self.y, self.z)
    

A=Teilgitter(10,3,23)
print(A)
#( 1 0 , 3 , 2 3 ) ; Koordinate 1 : 3 , Koordinate 2 : 4
B = Teilgitter(14,4,34)
print(B)
#( 1 4 , 4 , 3 4 ) ; Koordinate 1 : 4 , Koordinate 2 : 6
print (A+B)
#( 2 4 , 7 , 5 7 ) ; Koordinate 1 : 7 , Koordinate 2 : 10
print(-3*A)
#( 3 0 , 9 , 6 9 ) ; Koordinate 1 : 9 , Koordinate 2 : 12
print(3*A)
#(-30,-9,-69) ; Koordinate 1 : 9, Koordinate 2 : 12
print(B*7)
#( 9 8 , 2 8 , 2 3 8 ) ; Koordinate 1 : 28 , Koordinate 2 : 42
print(A*B)
#934
print(A.copy())
#( 1 0 , 3 , 2 3 ) ; Koordinate 1 : 3 , Koordinate 2 : 4
print(Teilgitter(9, 5, 0))
#( 9 , 5 , 0 ) ; Koordinate 1 : 5 , Koordinate 2 : -1