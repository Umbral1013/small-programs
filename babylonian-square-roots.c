/*
 * TÍTULO DEL DOCUMENTO: Raíces cuadradas resueltas con el algoritmo
 * babilónico.
 * NOMBRE DEL ARCHIVO: babylonian-square-roots.c
 * AUTOR: Umbral1013.
 * PROPÓSITO: Encontrar la raíz cuadrada de un número usando el método
 * babilónico.
 * FECHA: mié 16 ago 2023 22:40:17
 *
 * Véase
 * https://es.wikipedia.org/wiki/C%C3%A1lculo_de_la_ra%C3%ADz_cuadrada#Algoritmo_babil%C3%B3nico
 */

#include "stdio.h"

int main() {
    	int base, altura, x;

    	printf("ALGORITMO BABILONICO (RAICES CUADRADAS)\n");
    	printf("Teclea el numero al que le quieres sacar raiz : ");
    	scanf("%d", &x);

    	base = x / 2;
    	altura = 2;

    	// Intentamos aproximar a b a la raíz cuadrada real.
    	while (base != altura) {
        	base = (base + altura) / 2;
        	altura = x / base;
    	}

    	printf("La raíz cuadrada de %d es: %d", x, base);
    	printf("\n");
    	return 0;
}
