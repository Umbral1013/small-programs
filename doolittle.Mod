(* Umbral1013, 2024/12/08, 2024/12/09 *)

MODULE Doolittle;

IMPORT Texts, Oberon;

CONST N = 3;

TYPE
	matriz = ARRAY N, N OF REAL;
	matriz2x2 = ARRAY 2, 2 OF REAL;
	vector = ARRAY N OF REAL;

VAR W: Texts.Writer;

PROCEDURE MostrarSistema(a: matriz; b: vector);
VAR i, j: INTEGER;
BEGIN
	Texts.WriteString(W, "Mostrando el sistema de ecuaciones:");
	Texts.WriteLn(W);

	FOR i := 0 TO N-1 DO
		FOR j := 0 TO N-1 DO
			Texts.WriteRealFix(W, a[i, j], 5, 2);
		END; (* FOR *)

		Texts.WriteString(W, " | ");
		Texts.WriteRealFix(W, b[i], 5, 2); Texts.WriteLn(W);
	END; (* FOR *)
END MostrarSistema;

PROCEDURE MostrarMatriz(a: matriz);
VAR i, j: INTEGER;
BEGIN
	FOR i := 0 TO N-1 DO
		FOR j := 0 TO N-1 DO Texts.WriteRealFix(W, a[i, j], 5, 2) END;
		Texts.WriteLn(W);
	END; (* FOR *)
END MostrarMatriz;

PROCEDURE Eliminacion(VAR upper, lower: matriz; pivote: REAL; fila: INTEGER);
VAR
	i, j: INTEGER;
	elim: REAL;
BEGIN
	FOR i := fila+1 TO N-1 DO
		FOR j := 0 TO N-1 DO
			IF j = fila THEN
				elim := upper[i, j] / pivote;
				lower[i, j] := elim;
			END;
			upper[i, j] := upper[i, j] - (elim * upper[fila, j]);
		END; (* FOR *)
	END; (* FOR *)
END Eliminacion;

PROCEDURE Factorizar(VAR lower, upper: matriz; m: matriz);
CONST mensaje = "Se ha factorizado exitosamente el sistema de ecuaciones.";
VAR
	i, j: INTEGER;
	pivote, elim: REAL;
BEGIN
	(* Inicializamos la matriz lower *)
	FOR i := 0 TO N-1 DO
		FOR j := 0 TO N-1 DO
			IF i = j THEN lower[i, j] := 1.0
			ELSE lower[i, j] := 0.0
			END;
		END;
	END;

	upper := m;
	pivote := 0.0; elim := 0.0;
	FOR i := 0 TO N-1 DO
		FOR j := 0 TO N-1 DO
			IF i = j THEN
				pivote := upper[i, j];
				Eliminacion(upper, lower, pivote, i);
			END; (* IF *)
		END; (* FOR *)
	END; (* FOR *)

	Texts.WriteString(W, mensaje); Texts.WriteLn(W);
	Texts.WriteString(W, "## Matriz L (lower) ##"); Texts.WriteLn(W);
	MostrarMatriz(lower);
	Texts.WriteString(W, "## Matriz U (upper) ##"); Texts.WriteLn(W);
	MostrarMatriz(upper);
END Factorizar;

PROCEDURE Do*;
VAR
	x, l, u: matriz;
	v, p: vector;
	i, j: INTEGER;
BEGIN
	FOR i := 0 TO N-1 DO
		FOR j := 0 TO N-1 DO x[i, j] := 1.0 + FLT(i + j) END;
		v[i] := 1.0;
	END;
	MostrarSistema(x, v);
	Factorizar(l, u, x);
	Texts.Append(Oberon.Log, W.buf);

	(* Esta vaina si funciona XD, es para conseguir la longitud del arreglo.
	Texts.WriteInt(W, LEN(x[0]), 2); Texts.WriteLn(W);
	*)
END Do;

BEGIN Texts.OpenWriter(W);
END Doolittle.
