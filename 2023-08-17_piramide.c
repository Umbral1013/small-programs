/* TÍTULO DEL DOCUMENTO: Pirámide.
 * NOMBRE DEL ARCHIVO: piramide.c
 * AUTOR: Umbral1013.
 * PROPÓSITO: Dibujar una 'pirámide' en la pantalla dada la magnitud de la
 * base en caracteres.
 * FECHA: jue 17 ago 2023 22:47:19
*/

#include "stdio.h"
#include "stdlib.h"

int main() {
    /* i es el contador de 'while'.
     * b es el número de caracteres que se quiere que ocupe la base.
     * s es el símbolo que se usará como caracter en la pirámide.
     */
    int i, b;
    char s;

    i = 0;
    // s podría ser cualquier otra cosa.
    s = 'x';

    printf("PIRAMIDE \n");
    printf("Cuantos caracteres de longitud deseas que tenga la base? : ");
    scanf("%d", &b);
    printf("Que caracter deseas usar? : ");
    scanf(" %c", &s);

    while (i <= b) {
        /* Esto imprime n caracteres, donde n es el número de línea (la
         * línea 1 tiene un caracter, la línea dos tiene dos caracteres...
         */
        for (int c = 0; c < i; c++) {
            printf("%c", s);
        }
        printf("\n");
        i++;
    }
}
