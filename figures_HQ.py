""" {{{
Programmer's name            : Umbral1013
Name of the program          : Geometric figures HQ
Date                         : Between September and December from 2020
                               Revision made on january 20, 2021
Description of the program   : Improved version of the first "figures.py"
------------------------------------

Where:
x is the magnitude of the side given at the start of the program.
""" }}}

from math import pi,tan,sqrt,radians,degrees
from os import system
from time import sleep


def limpiarEspera():
    system("clear")
    sleep(1)


def circulo():
    """
    Obtain the radius, area and diameter of a circle using only the
    circumference.
    """
    circunferencia = float(input("Introduce la circunferencia del círculo\n"))
    radio = circunferencia / (2 * pi)
    area = (pi) * (radio**2)
    diametro = radio * 2
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Radio = %.2f" %radio, end=" | ")
    print("Diámetro = %.2f" %diametro, "\n----")
    return


def trianguloEquilatero():
    """
    Obtain the height, perimeter, and area of an equilateral triangle using the
    value of one side.
    """
    valorLado = float(input("Ingresa la medida de un lado\n"))
    altura = sqrt(valorLado**2 - (1/2 * valorLado)**2)
    perimetro = valorLado*3
    area = ((sqrt(3)) / 4) * valorLado**2
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Perímetro = %.2f" %perimetro, end=" | ")
    print("Altura = %.2f" %altura, "\n----")
    return


def cuadrado():
    """
    Get the area and perimeter of a square using the value of its side.
    """
    valorLado = float(input("Introduce la medida de un lado\n"))
    area = valorLado**2
    perimetro = valorLado*4
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Perímetro = %.2f" %perimetro, "\n----")
    return


def rectangulo():
    """
    Obtain the sizes of the perimeter and area of a rectangle using the values
    of its height and base.
    """
    baseRectangulo = float(input("Introduce la medida de la base\n"))
    alturaRectangulo = float(input("Introduce la medida de la altura\n"))
    perimetro = (2*baseRectangulo) + (2*alturaRectangulo)
    area = baseRectangulo*alturaRectangulo
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Perímetro = %.2f" %perimetro, "\n----")
    return


def rombo():
    """
    Obtain the area and the value of the sides of a rhombus using the
    magnitudes of its both diagonals.
    """
    diagonalMayor = float(input("Introduce la medida de la diagonal mayor\n"))
    diagonalMenor = float(input("Introduce la medida de la diagonal menor\n"))
    hipotenusa = sqrt(((1/2 * diagonalMayor)**2 + (1/2 * diagonalMenor)**2))
    area = (diagonalMayor*diagonalMenor)/2
    perimetro = 4*hipotenusa
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Lado = %.2f" %hipotenusa, end=" | ")
    print("Perímetro = %.2f" %perimetro, "\n----")
    return


def trapecioIsoceles():
    """
    Get the area, perimeter and height of an isosceles trapezoid using the
    sizes of both bases and the measurement of a side.
    """
    baseMayor = float(input("Introduce la base mayor\n"))
    baseMenor = float(input("Introduce la base menor\n"))
    valorLado = float(input("Introduce la medida de un lado\n"))
    pitagoras = (baseMayor-baseMenor)/2
    altura = sqrt(valorLado**2-pitagoras**2)
    area = ((baseMayor+baseMenor)*altura)/2
    perimetro = baseMayor+baseMenor+(2*valorLado)
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Perímetro = %.2f" %perimetro, end=" ")
    print("Altura = %.2f" %altura, "\n----")
    return


def poligono(x):
    """
    Get the area, perimeter and apothem using the size of a side.
    """
    valorLado = float(input("Introduce la medida de un lado\n"))
    angulo = radians(360 / (2 * x))
    perimetro = valorLado * x
    apotema = valorLado / (2 * tan(angulo))
    area = (perimetro * apotema) / 2
    limpiarEspera()
    print("----\nÁrea = %.2f" %area, end=" | ")
    print("Perímetro = %.2f" %perimetro, end=" | ")
    print("Apotema = %.2f" %apotema, "\n----")
    return


def filtroCuadrilatero():
    """
    Helps the program to decide which function of the above to use in the case
    of a quadrilateral.
    """
    cuadrilatero = ""
    while cuadrilatero != 1 and cuadrilatero != 2 and cuadrilatero != 3 and cuadrilatero != 4:
        cuadrilatero = int(input("1.) Cuadrado\n2.) Rectángulo\n3.) Rombo\n4.) Trapecio isóceles\n"))
        if cuadrilatero == 1:
            print("CUADRADO\n----")
            limpiarEspera()
            cuadrado()
        elif cuadrilatero == 2:
            limpiarEspera()
            print("RECTÁNGULO\n----")
            rectangulo()
        elif cuadrilatero == 3:
            limpiarEspera()
            print("ROMBO\n----")
            rombo()
        elif cuadrilatero == 4:
            limpiarEspera()
            print("TRAPECIO ISÓCELES\n----")
            trapecioIsoceles()


def filtro(x):
    """
    This is where the program decides which function to use if the figure
    doesn't have 4 sides.
    """
    if x <= 0:
        limpiarEspera()
        input("Ninguna figura tiene 0 lados.")
        return
    elif x in [1,2]:     # "in [1,2]" is more or less the same as "x == 1 and x == 2"
        limpiarEspera()
        print("CIRCULO\n----")
        circulo()
    elif x == 3:
        limpiarEspera()
        print("TRIÁNGULO EQUILÁTERO\n----")
        trianguloEquilatero()
    elif x == 4:
        limpiarEspera()
        print("CUADRILÁTERO\n----")
        filtroCuadrilatero()
    elif x >= 5:
        limpiarEspera()
        print("POLÍGONO REGULAR\n----")
        poligono(lados)


volverMenu = "s"

# This is where the magic happens.
while volverMenu == "s" or volverMenu == "Si":
    limpiarEspera()
    lados = int(input("FIGURAS\n----\nIngresa el número de lados de tu figura\n----\n"))
    filtro(lados)
    volverMenu = input("¿Desea volver al menú principal? (s/n)\n")
