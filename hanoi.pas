(*
Nombre del programador: Umbral1013.
Nombre del programa: Torre de Hanoi.
Fecha: 2024/04/12.
Descripcion del programa: Calcula el numero minimo de movimientos necesarios
para resolver la torre de Hanoi con X discos (1 <= X <= 30).
Historial de versiones:
  01 - 2024/04/12 - Se crea el documento. Primera version funciona.
  02 - 2024/04/13 - Se pulio el codigo.
*)

PROGRAM Hanoi;

(* Claro, si quiero que siga funcionando, todo tiene que ser un longint...
   Ahora, el rango de esta cosa deberia ser 0 < x < 2^31 - 1
*)
FUNCTION Hanoi(a: LongInt): LongInt;
VAR res: LongInt;
BEGIN
  res := 0;

  IF a = 1 THEN res := 1 ELSE res := 2*Hanoi(a-1) + 1;

  Hanoi := res; (* Return *)
END;

VAR discos: Integer;
  movimientos: LongInt;
BEGIN (* Main *)
  discos := 0; movimientos := 0;
  Write('Teclea el numero de discos: ');
  Readln(discos);

  WHILE (discos < 1) OR (discos > 30) DO
  BEGIN
      Writeln('Teclea un numero de discos valido.');
      Readln(discos);
  END;

  movimientos := Hanoi(discos);
  Writeln('El numero minimo de movimientos necesarios es: ', movimientos);
END. (* Main *)
