<<<<<<< HEAD
=======
# Beispiel einer Int-Vektorklasse

>>>>>>> 5e58cffd2eda890382f8d07d72a1d8458ad7c0da
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

<<<<<<< HEAD
=======

>>>>>>> 5e58cffd2eda890382f8d07d72a1d8458ad7c0da
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
<<<<<<< HEAD
print(A) #( 1 0 , 3 , 2 3 ) ; Koordinate 1 : 3 , Koordinate 2 : 4
#B = Teilgitter(14,4,34)
#print(B) #( 1 4 , 4 , 3 4 ) ; Koordinate 1 : 4 , Koordinate 2 : 6
#print (A+B) #( 2 4 , 7 , 5 7 ) ; Koordinate 1 : 7 , Koordinate 2 : 10
#print(-3*A) #( 3 0 , 9 , 6 9 ) ; Koordinate 1 : 9 , Koordinate 2 : 12
#print(3*A) #(-30,-9,-69) ; Koordinate 1 : 9, Koordinate 2 : 12
#print(B*7) #( 9 8 , 2 8 , 2 3 8 ) ; Koordinate 1 : 28 , Koordinate 2 : 42
#print(A*B) #934
#print(A.copy()) #( 1 0 , 3 , 2 3 ) ; Koordinate 1 : 3 , Koordinate 2 : 4
#print(Teilgitter(9, 5, 0)) #( 9 , 5 , 0 ) ; Koordinate 1 : 5 , Koordinate 2 : -1
=======
B = Teilgitter(14,4,34)
print(A*B)
#934
>>>>>>> 5e58cffd2eda890382f8d07d72a1d8458ad7c0da
