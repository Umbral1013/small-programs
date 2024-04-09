MODULE Espirales; (* Umbral1013 2024/04/08 *)
	IMPORT Texts, Oberon;
	VAR W: Texts.Writer;

	PROCEDURE Espirales(VAR N: INTEGER);
		CONST linea = "X";
			espacio = " ";
		VAR L: INTEGER;
			x: INTEGER;
			y: INTEGER;
			a: INTEGER;
			b: INTEGER;
			u: INTEGER;
			v: INTEGER;
			d: INTEGER;
	BEGIN
		FOR x := 0 TO N-1 DO
			FOR y := 0 TO N-1 DO
				(* Reflejo (x,y) en el cuadrante superior izquierdo como (a,b) *)
				a := x;
				b := y;
				IF a >= (N DIV 2) THEN a := N - a - 1 END ;
				IF b >= (N DIV 2) THEN b := N - b - 1 END ;
				
				(* Calculo la distancia desde el anillo central. *)
				u := ABS(a - N DIV 2);
				v := ABS(b - N DIV 2);
				IF u > v THEN d := u ELSE d := v END ;
				L := N DIV 2;
				IF N MOD 4 = 0 THEN L := L - 1 END ;

				(* Arreglo la diagonal superior-izquierda a inferior-derecha *)
				IF( y = x+1) & (y <= L) THEN d := d + 1 END ;

				(* Imprimo los caracteres. *)
				IF (d + N DIV 2) MOD 2 = 0 THEN
					Texts.Write(W, linea)
				ELSE
					Texts.Write(W, espacio)
				END ;
			END ;
			Texts.WriteLn(W)
		END ;
	END Espirales ;
	
	PROCEDURE Generar*;
		VAR tam: INTEGER;
	BEGIN
		tam := 17;
		Espirales(tam);
		Texts.Append(Oberon.Log, W.buf)
	END Generar ;
BEGIN Texts.OpenWriter(W)
END Espirales.

(*
VIA https://stackoverflow.com/a/53343715

ALGORITMO ORIGINAL
Si es la primera o la ultima linea, escribe un caracter
Si no, entonces...
	Si estas en la ultima columna, pon un caracter, si no...
		Si estas en la primera mitad de filas, entonces...
		Si no, si estas en la segunda mitad de filas, entonces...
		Si no, N es impar, y estas en el centro, entonces...
*)
