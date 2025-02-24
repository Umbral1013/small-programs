(* Umbral1013, 2025/02/10 *)
MODULE NumericalMethods;

IMPORT Texts, Oberon, MyMath;

VAR W: Texts.Writer;

PROCEDURE Bisection*;
CONST
	PAD = 2;
	ZEROPAD = 12;
	ERROR = 0.001;
VAR
	(* fc is meant to be read as 'f of c'. *)
	a, b, c, fc, oldC, percentageError: REAL;
	i: INTEGER;
BEGIN
	a := 4.0;	b := 7.0;	c := (a + b) / 2.0;
	fc := 0.0;	oldC := 0.0;	percentageError := 0.0;

	i := 0;
	REPEAT
		(* We show results. *)
		Texts.WriteString(W, "Iteration: "); Texts.WriteInt(W, i, PAD); Texts.WriteLn(W);
		Texts.WriteString(W, "a: "); Texts.WriteReal(W, a, ZEROPAD); Texts.WriteLn(W);
		Texts.WriteString(W, "b: "); Texts.WriteReal(W, b, ZEROPAD); Texts.WriteLn(W);
		Texts.WriteString(W, "c: "); Texts.WriteReal(W, c, ZEROPAD); Texts.WriteLn(W);
		Texts.WriteString(W, "f(c): "); Texts.WriteReal(W, fc, ZEROPAD); Texts.WriteLn(W);
		Texts.WriteString(W, "Percentage error: ");
		Texts.WriteReal(W, percentageError, ZEROPAD); Texts.WriteString(W, "%"); Texts.WriteLn(W);

		(* This was quite a long function, so I had to break it up. *)
		fc := MyMath.ln(c) - 1.8;

		(* If f(c) is zero, it means we have found the root. *)
		IF fc > 0.0 THEN b := c
		ELSIF fc < 0.0 THEN a := c END;

		oldC := c;
		c := (a + b) / 2.0;
		percentageError := ABS( (c - oldC) / c) * 100.0;

		INC(i);
	UNTIL (percentageError < ERROR) OR (fc = 0.0);
END Bisection;

PROCEDURE Do*;
BEGIN
	Bisection;
	Texts.Append(Oberon.Log, W.buf)
END Do;

BEGIN Texts.OpenWriter(W)
END NumericalMethods.
 
