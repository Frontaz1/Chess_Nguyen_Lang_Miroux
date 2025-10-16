Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTest >> testIsPiece [ 
	"Test if the knightPiece is a piece"
	| knightPiece |
	
   knightPiece := MyKnight new.
	self assert: (knightPiece isPiece).
	
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnightOnBlackSquare [ 
	"render knight according to its colour
	 must render 'm' if it is a black knight on a black square"

	| blackKnight aSquare |
	blackKnight := MyKnight black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackKnight) equals: 'm'.
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnightOnWhiteSquare [ 
	"render knight according to its colour
	 must render 'M' if it is a black knight on a hite square"

	| blackKnight aSquare |
	blackKnight := MyKnight black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackKnight) equals: 'M'.
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightOnABlackSquare [
	"render knight according to its colour
	 must render 'n' if it is a white knight on a black square"

	| whiteKnight aSquare |
	whiteKnight := MyKnight white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whiteKnight) equals: 'n'.
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightOnAWhiteSquare [
	"render knight according to its colour
	 must render 'N' if it is a white knight on a white square"

	| whiteKnight aSquare |
	whiteKnight := MyKnight white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whiteKnight) equals: 'N'.
]
