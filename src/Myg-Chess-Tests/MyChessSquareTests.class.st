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
	pawn := MyPawn white.
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
MyChessSquareTests >> testNilSquareContents [
    | nilSquare |
    nilSquare := MyNilSquare new.

    self assert: (nilSquare contents isKindOf: MyNilPiece).
]

{ #category : 'tests' }
MyChessSquareTests >> testNilSquareDirectionalMethodsReturnSelf [

	| nilSquare |
	nilSquare := MyNilSquare new.
	
	self assert: nilSquare up identicalTo: nilSquare.
	self assert: nilSquare down identicalTo: nilSquare.
	self assert: nilSquare left identicalTo: nilSquare.
	self assert: nilSquare right identicalTo: nilSquare
]

{ #category : 'tests' }
MyChessSquareTests >> testSetContentsOnASquare [
	| square pawn board text|
	board := MyChessBoard empty.
	pawn := MyPawn white.
	square := board at: 'e4'.
	
	"The square content is a pawn"
	square contents: pawn.
	self assert: square hasPiece.
	self assert: square contents class equals: MyPawn.
	"For the moment this line doesn't work"
	self assert: (square renderPiece: square contents) equals: 'P'.
]

{ #category : 'tests' }
MyChessSquareTests >> testSquarePlusReturnsNilSquareOutsideBoard [
	| board square result |
	board := MyChessBoard empty.
	square := board at: 'h8'.

	"case a droite(hors plateau)"
	result := square + (1@0).
	self assert: result class equals: MyNilSquare.
	
	"case en haut(hors plateau)"
	result := square + (0@1).
	self assert: result class equals: MyNilSquare.
]
