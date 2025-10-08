Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTest >> testRenderKnight [
	"render knight according to its colour
	 must render 'N' if it is a white knight
	 must render 'n' if it is a black knight"

	| whiteKnight blackKnight aSquare |
	whiteKnight := MyKnight white.
	blackKnight := MyKnight black.
	
	aSquare := MyChessSquare new.
	self assert: (aSquare renderPiece: whiteKnight) equals: 'N'.
	self assert: (aSquare renderPiece: blackKnight) equals: 'n'.
]
