(* Umbral1013, 2025/03/12 *)
MODULE PointerTest;

IMPORT Texts, Oberon;

TYPE Node = POINTER TO NodeDesc;
	NodeDesc = RECORD next: Node END;
	CharNode = POINTER TO CharNodeDesc;
	CharNodeDesc = RECORD (NodeDesc) data: CHAR END;

VAR W: Texts.Writer;

PROCEDURE Go*;
VAR list: ARRAY 32 OF Node; elem, oldElem: CharNode;
	i, j: INTEGER;
BEGIN j := 0;
	NEW(elem); elem.data := "A"; (* Root. *)
	FOR i := ORD("B") TO ORD("Z") DO
		oldElem := elem;
		NEW(elem); elem.data := CHR(i);
		oldElem.next := elem;
		list[j] := oldElem; list[j + 1] := elem; INC(j);
	END;

	elem := list[0](CharNode); (* We set it to the root. *)
	WHILE elem # NIL DO
		Texts.Write(W, elem.data); Texts.WriteLn(W);
		elem := elem.next(CharNode);
	END;

	Texts.Append(Oberon.Log, W.buf)
END Go;

BEGIN Texts.OpenWriter(W)
END PointerTest.

ORP.Compile PointerTest.Mod ~
System.Free PointerTest ~
PointerTest.Go ~
