/* TÍTULO DEL DOCUMENTO: Raíces cuadradas resueltas con el algoritmo
 * babilónico.
 * NOMBRE DEL ARCHIVO: raices-babilonicas.c
 * AUTOR: Umbral1013.
 * PROPÓSITO: Encontrar la raíz cuadrada de un número usando el método
 * babilónico.
 * FECHA: mié 16 ago 2023 22:40:17
 *
 * Véase
 * https://es.wikipedia.org/wiki/C%C3%A1lculo_de_la_ra%C3%ADz_cuadrada#Algoritmo_babil%C3%B3nico
 */

#include "stdio.h"
#include "stdlib.h"

int main() {
    /* VARIABLES
     * b: Base del rectángulo hipotético.
     * h: Altura del rectángulo hipotético.
     * x: Número al que se le quiere sacar raíz.
     */
    int b, h, x;

    printf("ALGORITMO BABILÓNICO PARA LAS RAÍCES CUADRADAS \n");
    printf("NOTA : Es mejor probar con números pequeños. \n");
    printf("------------------------------------------ \n");
    printf("Inserta el numero al que le quieres sacar raiz : ");
    scanf("%d", &x);

    b = x / 2;
    h = 2;

    // Intentamos aproximar a b a la raíz cuadrada real.
    while (b != h)
    {
        b = (h + b) / 2;
        h = x / b;
    }

    printf("La raíz cuadrada es : %d \n", b);
    return (0);
}
