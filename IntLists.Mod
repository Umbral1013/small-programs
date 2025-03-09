(* Umbral1013, 2025/03/09 *)
MODULE IntLists;

CONST SIZE = 100;

TYPE TIntList* = POINTER TO TIntListDesc;

TIntListDesc = RECORD
	data: ARRAY SIZE OF INTEGER;
	last: INTEGER;
	isValidPosition: PROCEDURE(self: TIntList; pos: INTEGER): BOOLEAN;
	isEmpty*, isFull*: PROCEDURE (self: TIntList): BOOLEAN;
	insertData*: PROCEDURE(VAR self: TIntList; x, pos: INTEGER);
	deleteData*: PROCEDURE(VAR self: TIntList; pos: INTEGER);
	retrieve*: PROCEDURE(self: TIntList; pos: INTEGER): INTEGER;
	erase*: PROCEDURE(VAR self: TIntList);
END;

PROCEDURE IsValidPosition(self: TIntList; pos: INTEGER): BOOLEAN;
BEGIN
RETURN (pos >= 0) & (pos <= self.last) END IsValidPosition;

PROCEDURE IsEmpty(self: TIntList): BOOLEAN;
BEGIN
RETURN self.last = -1 END IsEmpty;

PROCEDURE IsFull(self: TIntList): BOOLEAN;
BEGIN
RETURN self.last = SIZE-1 END IsFull;

PROCEDURE Retrieve(self: TIntList; pos: INTEGER): INTEGER;
BEGIN ASSERT( self.isValidPosition(self, pos) );
RETURN self.data[pos] END Retrieve;

PROCEDURE InsertData(VAR self: TIntList; x, pos: INTEGER);
VAR i: INTEGER;
BEGIN ASSERT( ~self.isFull(self) );
	ASSERT( self.isValidPosition(self, pos) OR (pos = -1) );

	i := self.last;
	WHILE i > pos DO
		self.data[i+1] := self.data[i];
		DEC(i);
	END;

	self.data[pos+1] := x;
	INC(self.last);
END InsertData;

PROCEDURE Erase(VAR self: TIntList);
BEGIN self.last := -1
END Erase;

PROCEDURE DeleteData(VAR self: TIntList; pos: INTEGER);
VAR i: INTEGER;
BEGIN ASSERT( self.isValidPosition(self, pos) );
	i := pos;
	WHILE i < self.last DO
		self.data[i] := self.data[i+1];
		INC(i);
	END;

	DEC(self.last);
END DeleteData;

PROCEDURE Init*(VAR self: TIntList);
BEGIN NEW(self);
	self.last := -1;
	self.isValidPosition := IsValidPosition;
	self.isEmpty := IsEmpty;
	self.isFull := IsFull;
	self.insertData := InsertData;
	self.deleteData := DeleteData;
	self.retrieve := Retrieve;
	self.erase := Erase;
END Init;

END IntLists.

ORP.Compile IntLists.Mod ~
System.Free IntLists ~
