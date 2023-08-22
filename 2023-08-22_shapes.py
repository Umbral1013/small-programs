"""
Programmer's name          : Umbral1013
Name of the program        : Shapes.
Date                       : Between September and December from 2020
                             Revision made on january 20, 2021
                             Revision made on february 15, 2021
                             Revision made on august 22, 2023.
Description of the program : Improved version of the first "figuras.py"
"""

from math import (pi, tan, sqrt, radians, degrees)
from os import system


def circle(radius):
    diameter = 2 * radius
    cmferens = pi * diameter    # cmferens is circumferens, latin.
    area = pi * (radius ** 2)
    return area, cmferens, diameter


def rectangle(b, h):
    # b is base.
    # h is height.
    perimeter = (2 * b) + (2 * h)
    area = h * b
    return perimeter, area


def rhombus(gDiagonal, lDiagonal):
    # gDiagonal stands for Greater Diagonal.
    # lDiagonal stands for Lesser Diagonal.

    # hypotns is hypotenuse.
    hypotns = sqrt(((1/2 * gDiagonal) ** 2 +
                    (1/2 * lDiagonal) ** 2
                    ))
    area = (gDiagonal * lDiagonal) / 2
    perimeter = 4 * hypotns
    return area, perimeter


def polygon(n, l):
    # n is the number of sides.
    # l is the lenght of one side.
    theta = radians(360 / (2 * n))
    perimeter = l * n
    apothem = l / (2 * tan(theta))
    area = (perimeter * apothem) / 2
    return perimeter, apothem, area


while True:
    system("clear")

    print("¿Qué figura tienes?")
    print("a) - Círculo")
    print("b) - Triángulo equilátero")
    print("c) - Cuadrado")
    print("d) - Rectángulo")
    print("e) - Rombo")
    print("f) - Polígono regular")

    shape = input("Tengo: ")

    # All of this ugly thing selects what do we want to do.
    if shape == "a":
        c = int(input("¿Cuál es el radio? : "))
        print(circle(c))
    elif shape == "b":
        lenght = int(input("¿Cuánto mide un lado? : "))
        print(polygon(3, lenght))
    elif shape == "c":
        lenght = int(input("¿Cuánto mide un lado? : "))
        print(polygon(4, lenght))
    elif shape == "d":
        base = int(input("¿Cuánto mide la base? : "))
        height = int(input("¿Cuánto mide la altura? : "))
        print(rectangle(base, height))
    elif shape == "e":
        greatD = int(input("¿Cuánto mide la diagonal mayor? : "))
        lessD = int(input("¿Cuánto mide la diagonal menor? : "))
        print(rhombus(greatD, lessD))
    elif shape == "f":
        sides = int(input("¿Cuántos lados tiene el polígono? : "))
        lenght = int(input("¿Cuánto mide un lado? : "))
        print(polygon(sides, lenght))
    else:
        print("Advertencia: No se ha reconocido esa opción.")

    leave = input("¿Deseas salir del programa? (s/n) : ")
    if leave == "s":
        break

input()
