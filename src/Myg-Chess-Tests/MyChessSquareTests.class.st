Class {
	#name : 'MyChessSquareTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTests >> testEmptyContents [

	| square pawn board|
	board := MyChessBoard empty.
	square := MyChessSquare color: MyWhiteSquare new.
	pawn := MyPawn white.
	board at: 'e4' put: pawn.
	square := board at: 'e4'.
	
	"The square content is a pawn"
	square contents: pawn.
	self assert: square hasPiece.
	
	"If we call emprtContents the content of the square should be MyNilPiece"
	square emptyContents.
	self assert: square contents class equals: MyNilPiece
]

{ #category : 'tests' }
MyChessSquareTests >> testInitializeSquare [
"Test to see if the initialization of ChessSquare is good (For the moment only contents of a square is tested)"
	| square |
	
square := MyChessSquare new.
"Verify that the content of my square is a NilPiece"
self assert: square contents class equals: MyNilPiece
]

{ #category : 'tests' }
MyChessSquareTests >> testSetContentsOnASquare [
	| square pawn board text|
	board := MyChessBoard empty.
	square := MyChessSquare color: MyWhiteSquare new.
	pawn := MyPawn white.
	board at: 'e4' put: pawn.
	square := board at: 'e4'.
	
	"The square content is a pawn"
	square contents: pawn.
	text := square contents renderPieceOn: self.
	self assert: square hasPiece.
	self assert: square contents class equals: MyPawn.
	"For the moment this line doesn't work"
	self assert: (square renderPiece: square contents) equals: 'p'.
]
