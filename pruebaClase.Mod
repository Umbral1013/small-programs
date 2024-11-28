(* Umbral1013, 2024/11/28 *)

MODULE PruebaClase;

IMPORT Texts, Oberon;

(* Interfaz. El asterisco hace que las cosas esten disponibles a otros modulos que importen a este. *)
TYPE Clase* = POINTER TO ClaseDesc;

ClaseDesc = RECORD
	x: INTEGER; (* Solo es un atributo de prueba. *)
	metodo: PROCEDURE; (* Solo es un metodo de prueba. *)
	next: Clase; (* Como una linked list, no? *)
END;

(* Despues de la definicion de nuevos tipos van las variables globales. *)
VAR W: Texts.Writer;

(* Implementacion de metodo *)
PROCEDURE metodo;
BEGIN
	Texts.WriteString(W, "Hola, soy un metodo."); Texts.WriteLn(W);
END metodo;

(* Comando principal. *)
PROCEDURE Do*;
VAR
	instancia: Clase;
BEGIN
	NEW(instancia);
	instancia.x := 10;
	instancia.metodo := metodo;
	instancia.metodo;
	Texts.WriteInt(W, instancia.x, 2);
	Texts.Append(Oberon.Log, W.buf);
END Do;

BEGIN Texts.OpenWriter(W)
END PruebaClase.
