# Beispiel einer Int-Vektorklasse

import math

class IntVektor:

    def __init__(self,x,y,z):
        if type(x) != type(0) or type(y) != type(0)or type(z) != type(0):
           raise TypeError("Vektoreintrag keine ganze Zahl.")
        self.x=x
        self.y=y
        self.z=z

    def __str__(self):
        return '({0:n},{1:n},{2:n})'.format(self.x,self.y,self.z)

    def __getitem__(self,i):
        if type(i) != type(0):
           raise TypeError("Index keine ganze Zahl.")
        if i<0 or i>2:
           raise IndexError("Index nicht im zul. Bereich.")
        elif i==0:
           return self.x
        elif i==1:
           return self.y
        elif i==2:
           return self.z

    def __add__(self,other):
        if isinstance(other,IntVektor):
           return IntVektor(self.x+other.x,self.y+other.y,self.z+other.z)
        else:
           raise TypeError("Formate passen nicht.")

    def __mul__(self,other):
        if isinstance(other,IntVektor):
           return self.x * other.x + self.y * other.y + self.z * other.z
        elif type(other) == type(0):
           return IntVektor(self.x * other, self.y * other, self.z * other)
        else:
           raise TypeError("Formate passen nicht.")

    def __rmul__(self,other):
        if isinstance(other,IntVektor):
           return self.x * other.x + self.y * other.y + self.z * other.z
        elif type(other) == type(0):
           return IntVektor(self.x * other, self.y * other, self.z * other)
        else:
           raise TypeError("Formate passen nicht.")

    def copy(self):
        return IntVektor(self.x,self.y,self.z)


class Teilgitter(IntVektor):

    def __init__(self, x, y, z):
        k1 = y
        k2_x = x - 2 * k1
        k2_z = (z - k1) / 5
        if k2_x != k2_z or (z - k1) % 5 != 0:  # Überprüfe, ob k2 ganzzahlig ist
            raise ValueError("Vektor liegt nicht im Teilgitter.")
        # Jetzt müssen wir k2 nur einmal berechnen, weil wir wissen, dass die anderen Bedingungen erfüllt sind.
        k2 = k2_x
        super().__init__(x, y, z)
        self.Koordinate_1 = k1
        self.Koordinate_2 = k2

    def __str__(self):
        return super().__str__() + "; Koordinate 1: {0}, Koordinate 2: {1}".format(self.Koordinate_1, self.Koordinate_2)
    

A=Teilgitter(10,3,23)
B = Teilgitter(14,4,34)
print(A*B)
#934