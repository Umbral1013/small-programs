(* Umbral1013, 2025/02/12 *)
MODULE MyMath;

PROCEDURE power*(x: REAL; n: INTEGER): REAL;
VAR
	y: REAL;
	i: INTEGER;
BEGIN
	y := 1.0; i := n;
	WHILE i > 0 DO
		IF ODD(i) THEN y := y * x END;
		x := x * x; i := i DIV 2;
	END;
	RETURN y
END power;

PROCEDURE ln*(arg: REAL): REAL;
CONST ITERATIONS = 10;
VAR
	result, x, term: REAL;
	i: INTEGER;
BEGIN
	ASSERT(arg > 0.0);

	result := 0.0;
	IF arg = 1.0 THEN result := 0.0 END;

	x := (arg - 1.0) / (arg + 1.0);
	term := x;
	i := 1;
	WHILE i <= ITERATIONS DO
		result := result + (1.0 / (2.0 * FLT(i) - 1.0) ) * term;
		term := term * power(x, 2);
		INC(i);
	END;

	result := 2.0 * result;
	RETURN result
END ln;

END MyMath. 
