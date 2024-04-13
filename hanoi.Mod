(*
Nombre del programador: Umbral1013.
Nombre del programa: Torres de Hanoi.
Fecha: 2024/04/12
Descripcion del programa: Calcula el numero minimo de movimientos necesarios para resolver
las Torres de Hanoi con el numero proporcionado de discos.
Historial de versiones:
	01 - 2024/04/12 - Se crea el documento. No compila.
	02 - 2024/04/13 - Se arreglan los errores, se simplifica el codigo.

Hanoi.Do ~
*)

MODULE Hanoi;
  IMPORT Texts, Oberon;
  VAR W: Texts.Writer;
  
  PROCEDURE Hanoi(a: INTEGER): INTEGER;
    VAR res: INTEGER;
  BEGIN res := 0;
    IF a = 1 THEN res := 1 ELSE res := 2*Hanoi(a-1) + 1 END;
    RETURN res
  END Hanoi ;

  PROCEDURE Do*;
    VAR discos: INTEGER;
      movimientos: INTEGER;
  BEGIN discos := 15; movimientos := Hanoi(discos);
    Texts.WriteString(W, "El numero minimo de movimientos con "); Texts.WriteInt(W, discos, 0);
    Texts.WriteString(W, " discos es: "); Texts.WriteInt(W, movimientos, 0); Texts.WriteLn(W);
    Texts.Append(Oberon.Log, W.buf);
  END Do ;

BEGIN Texts.OpenWriter(W)
END Hanoi.
