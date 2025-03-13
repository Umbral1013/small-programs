(* Umbral1013, 2025/03/12 *)

MODULE PointerTest;

IMPORT Texts, Oberon;

TYPE Node = POINTER TO NodeDesc;
	NodeDesc = RECORD next: Node END;
	CharNode = POINTER TO CharNodeDesc;
	CharNodeDesc = RECORD (NodeDesc) data: CHAR END;
	IntNode = POINTER TO IntNodeDesc;
	IntNodeDesc = RECORD (NodeDesc) data: INTEGER END;

VAR W: Texts.Writer;

PROCEDURE PrintNode(n: Node);
BEGIN
	CASE n OF
	CharNode: Texts.Write(W, n(CharNode).data)
	| IntNode: Texts.WriteInt(W, n(IntNode).data, 5)
	END;
END PrintNode;

PROCEDURE Go*;
CONST N = 32;
VAR
	list: ARRAY N OF Node;
	elem, oldElem: CharNode;
	intElem: IntNode;
	i, j: INTEGER;
BEGIN

	(* Introducing new elements on the array. *)
	NEW(elem); elem.data := "A";					(* Root. *)
	j := 0;
	FOR i := ORD("B") TO ORD("Z") DO
		oldElem := elem;
		NEW(elem); elem.data := CHR(i);
		oldElem.next := elem;
		list[j] := oldElem; list[j + 1] := elem; INC(j);
	END;

	(* This tests the traversal of the nodes by the next element.
	elem := list[0](CharNode);					(* We set it to the root. *)
	WHILE elem # NIL DO
		Texts.Write(W, elem.data); Texts.WriteLn(W);
		elem := elem.next(CharNode);
	END;
	*)

	(* Some shady stuff going on starting from here. *)
	NEW(intElem); intElem.data := 5;				(* Element of another type. *)
	list[26] := intElem;						(* Adding it to the array. *)

	elem := list[20](CharNode);
	elem.next := intElem;						(* Making the next element a disctint type. *)
	
	(* Printing all the elements on the array. *)
	i := 0;
	WHILE (list[i] # NIL) & (i < N) DO
		PrintNode(list[i]);
		INC(i);
	END;

	Texts.Append(Oberon.Log, W.buf)
END Go;

BEGIN Texts.OpenWriter(W)
END PointerTest.

ORP.Compile PointerTest.Mod ~
System.Free PointerTest ~
PointerTest.Go ~
