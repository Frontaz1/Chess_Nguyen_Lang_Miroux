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
MyKingTest >> testRenderBlackKingOnABlackSquare [
	"render king according to its colour
	 must render 'l' if it is a black king on a black square"

	| blackKing aSquare |
	blackKing := MyKing black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackKing) equals: 'l'.
]

{ #category : 'tests' }
MyKingTest >> testRenderBlackKingOnAWhiteSquare [
	"render king according to its colour
	 must render 'L' if it is a black king on a white square"

	| blackKing aSquare |
	blackKing := MyKing black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackKing) equals: 'L'.
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingOnABlackSquare [
	"render king according to its colour
	 must render 'k' if it is a white king on a black square"

	| whiteKing aSquare |
	whiteKing := MyKing white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whiteKing) equals: 'k'.
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingOnAWhiteSquare [
	"render king according to its colour
	 must render 'K' if it is a white king on a white square"

	| whiteKing aSquare |
	whiteKing := MyKing white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whiteKing) equals: 'K'.
]
