(*
Nombre del programador: Umbral1013.
Nombre del programa: Raices babilonicas.
Fecha: 2024/04/14.
Descripcion del programa: Calcula la raiz cuadrada de un numero x usando el algoritmo
descubierto por los babilonicos (o algo asi, no se).

RB.Go ~
*)

MODULE RB;
	IMPORT Texts, Oberon;
	VAR W: Texts.Writer;
	
	PROCEDURE Raiz(a: INTEGER): INTEGER;
		VAR base, altura: INTEGER;
	BEGIN base := a DIV 2; altura := 2;
		WHILE base # altura DO
			base := (base + altura) DIV 2;
			altura := a DIV base
		END;
		RETURN base
	END Raiz;

	PROCEDURE Go*;
		CONST N = 30;
		VAR x: INTEGER;
			res: INTEGER;
			s: ARRAY N OF CHAR;
	BEGIN x := 144; res := Raiz(x);
		s := "La raiz cuadrada es: ";
		Texts.WriteString(W, s); Texts.WriteInt(W, res, 0); Texts.WriteLn(W);
		Texts.Append(Oberon.Log, W.buf)
	END Go;

BEGIN Texts.OpenWriter(W)
END RB.
