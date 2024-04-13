/*
 * TITULO DEL DOCUMENTO: Torre de Hanoi.
 * NOMBRE DEL ARCHIVO: 2024-04-12_hanoi.c
 * AUTOR: Umbral1013.
 * PROPOSITO: Calcula el numero minimo de movimientos necesarios
 * para resolver la torre de Hanoi con X discos (1 <= X <= 30).
 * FECHA: sáb 13 abr 2024 15:09:16
 * HISTORIAL DEL DOCUMENTO:
 *     Version - Fecha - Comentarios
 *     01 - 2024/04/13 - Se crea el documento.
 */

#include <stdio.h>

int hanoi(int a)
{
    int res = 0;

    if (a == 1)
        res = 1;
    else if (a > 1)
        res = 2*hanoi(a-1) + 1;

    return res;
}

int main(void)
{
    const int minDiscos = 1;
    const int maxDiscos = 31;
    int discos = 0;
    int movimientos = 0;
    printf("Teclea el numero de discos: ");
    scanf("%d", &discos);

    while (discos < minDiscos || discos > maxDiscos) {
        printf("Teclea un numero de discos valido: ");
        scanf("%d", &discos);
    }
    
    movimientos = hanoi(discos);
    printf("Para %d discos se tienen que hacer %d movimientos.\n",
        discos, movimientos);

    return 0;
}
