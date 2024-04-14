(*
Nombre del programador: Umbral1013.
Nombre del programa: Torres de Hanoi.
Fecha: 2024/04/12
Descripcion del programa: Calcula el numero minimo de movimientos necesarios para resolver
las Torres de Hanoi con el numero proporcionado de discos.
Historial de versiones:
	01 - 2024/04/12 - Se crea el documento. No compila.
	02 - 2024/04/13 - Se arreglan los errores, se simplifica el codigo.
	03 - 2024/04/14 - Se simplifico aun mas el codigo.

Hanoi.Go ~
*)

MODULE Hanoi;
  IMPORT Texts, Oberon;
  VAR W: Texts.Writer;
  
  PROCEDURE Hanoi(a: INTEGER): INTEGER;
    VAR res: INTEGER;
  BEGIN
    res := 0;
    IF a = 1 THEN res := 1 ELSE res := 2*Hanoi(a-1) + 1 END;
    RETURN res
  END Hanoi ;

  PROCEDURE Go*;
    CONST N = 50;
    VAR discos: INTEGER;
      mov: INTEGER;
      s: ARRAY N OF CHAR;
  BEGIN discos := 15; mov := Hanoi(discos);
    s := "El numero de movimientos necesarios es: ";
    Texts.WriteString(W, s); Texts.WriteInt(W, mov, 0);
    Texts.WriteLn(W);
    Texts.Append(Oberon.Log, W.buf);
  END Go ;

BEGIN Texts.OpenWriter(W)
END Hano
