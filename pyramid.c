/*
 * TÍTULO DEL DOCUMENTO: Pirámide.
 * NOMBRE DEL ARCHIVO: pyramid.c
 * AUTOR: Umbral1013.
 * PROPÓSITO: Dibujar una 'pirámide' en la pantalla dada la magnitud de la
 * base en caracteres.
 * FECHA: jue 17 ago 2023 22:47:19
 */

#include "stdio.h"

int main() {
	/*
     	 * base es el número de caracteres que se quiere que ocupe la base.
     	 * simbolo es el caracter que se usará como 'bloque' en la pirámide.
     	 */
    	int i, base;
    	char simbolo;

    	simbolo = 'x';

    	printf("PIRAMIDE\n");
    	printf("Cuantos caracteres de longitud deseas que tenga la base? : ");
    	scanf("%d", &base);
    	printf("Que caracter deseas usar? : ");
    	scanf(" %c", &simbolo);

    	i = 0;
    	while (i <= base) {
        	/*
        	 * Esto imprime n caracteres, donde n es el número de línea (la
         	 * primera linea tiene un caracter, la línea dos tiene dos caracteres...
         	 */
        	for (int c = 0; c < i; c++)
            		printf("%c", simbolo);

        	printf("\n");
        	i++;
    	}
    	return 0;
}
