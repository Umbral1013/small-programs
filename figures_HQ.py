"""
Programmer's name            : Umbral1013
Name of the program          : Geometric figures HQ
Date                         : Between September and December from 2020
                               Revision made on january 20, 2021
                               Revision made on february 15, 2021
Description of the program   : Improved version of the first "figures.py"
"""

from math import pi,tan,sqrt,radians,degrees
from os import system
from time import sleep


def limpiarEspera():
    system("clear")
    sleep(1)


def circulo(circunferencia):
    """
    Obtener el radio, área y diámetro de un círculo 
    usando únicamente la circunferencia.
    """
    radio = circunferencia / (2 * pi)
    area = (pi) * (radio ** 2)
    diametro = radio * 2
    limpiarEspera()
    return radio, area, diametro


def trianguloEquilatero(lado):
    """
    Obtener la altura, perímetro y área de un triángulo equilátero
    usando el valor de un lado.
    """
    altura = sqrt(lado ** 2 - (1/2 * lado) ** 2)
    perimetro = lado * 3
    area = ((sqrt(3)) / 4) * lado ** 2
    limpiarEspera()
    return altura, area, perimetro


def cuadrado(lado):
    """
    Obtener el área y perímetro de un cuadrado
    usando la medida de su lado.
    """
    area = valorLado**2
    perimetro = valorLado*4
    limpiarEspera()
    return area, perimetro


def rectangulo(base, altura):
    """
    Obtener el área y perímetro de un rectángulo
    usando los valores de su altura y base.
    """
    perimetro = (2 * base) + (2 * altura)
    area = base * altura
    limpiarEspera()
    return perimetro, area


def rombo(diagonalMayor, diagonalMenor):
    """
    Obtener el área y perímetro de un rombo
    usando el tamaño de sus dos diagonales.
    """
    hipotenusa = sqrt(((1/2 * diagonalMayor) ** 2 + (1/2 * diagonalMenor) ** 2))
    area = (diagonalMayor * diagonalMenor) / 2
    perimetro = 4 * hipotenusa
    limpiarEspera()
    return area, perimetro


def trapecioIsoceles(baseMayor, baseMenor, lado):
    """
    Conseguir el área, perímetro y altura de un trapecio isóceles
    usando sus dos bases y la medida de un lado.
    """
    pitagoras = (baseMayor - baseMenor) / 2
    altura = sqrt(lado ** 2 - pitagoras ** 2)
    area = ((baseMayor + baseMenor) * altura) / 2
    perimetro = baseMayor + baseMenor + (2 * valorLado)
    limpiarEspera()
    return altura, area, perimetro


def poligono(numeroDeLados, tamañoLado):
    """
    Obtener el área, perímetro y apotema de un polígono regular
    usando el tamaño de un lado.
    """
    angulo = radians(360 / (2 * x))
    perimetro = tamañoLado * numeroDeLados
    apotema = tamañoLado / (2 * tan(angulo))
    area = (perimetro * apotema) / 2
    limpiarEspera()
    return perimetro, apotema, area

bienvenida = """
¡Bienvenido!

Ésta herramienta puede ayudarte a conseguir datos relevantes
sobre algunas figuras geométricas a partir de como máximo
tres datos de entrada. Éstos datos varían dependiendo de tu figura
geométrica.

No están incluidas las figuras geométricas irregulares.
En el caso de los triángulos, de momento sólamente están soportados
los triángulos equiláteros.

Es importante que cuando ingreses los datos, únicamente escribas su
su medida numérica SIN LA UNIDAD DE MEDIDA.

Por ejemplo, ésto está bien:
    Ingresa la medida de su circunferencia.
    >>> 3

Pero esto no:
    Ingresa la medida de su circunferencia.
    >>> 3cm

Presiona ENTER para continuar...
"""

limpiarEspera()
input(bienvenida)
limpiarEspera()
print("¿Cuántos lados tiene tu figura?")
ladosDeMiFigura = int(input())

if ladosDeMiFigura in [1, 2]:
    print("Ingresa la medida de su circunferencia")
    circunferencia = int(input())
    print(circulo(circunferencia))
elif ladosDeMiFigura == 3:
    print("Ingresa la medida del lado")
    ladoTriangulo = int(input())
    print(trianguloEquilatero(ladoTriangulo))
