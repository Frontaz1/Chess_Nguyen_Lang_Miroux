Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testRenderKing [
	"render king according to its colour
	 must render 'K' if it is a white king
	 must render 'k' if it is a black king"

	| whiteKing blackKing aSquare |
	whiteKing := MyKing white.
	blackKing := MyKing black.
	
	aSquare := MyChessSquare new.
	self assert: (aSquare renderPiece: whiteKing) equals: 'K'.
	self assert: (aSquare renderPiece: blackKing ) equals: 'k'.
]
