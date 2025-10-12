Class {
	#name : 'MyQueenTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTests >> testRenderBlackQueenOnABlackSquare [
	"render queen according to its colour
	 must render 'w' if it is a black queen on a black square"

	| blackQueen aSquare |
	blackQueen := MyQueen black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackQueen) equals: 'w'.
]

{ #category : 'tests' }
MyQueenTests >> testRenderBlackQueenOnAWhiteSquare [
	"render queen according to its colour
	 must render 'W' if it is a black queen on a white square"

	| blackQueen aSquare |
	blackQueen := MyQueen black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackQueen) equals: 'W'.
]

{ #category : 'tests' }
MyQueenTests >> testRenderWhiteQueenOnABlackSquare [
	"render queen according to its colour
	 must render 'q' if it is a white queen on a black square"

	| whiteQueen aSquare |
	whiteQueen := MyQueen white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whiteQueen) equals: 'q'.
]

{ #category : 'tests' }
MyQueenTests >> testRenderWhiteQueenOnAWhiteSquare [
	"render queen according to its colour
	 must render 'Q' if it is a white queen on a white square"

	| whiteQueen aSquare |
	whiteQueen := MyQueen white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whiteQueen) equals: 'Q'.
]
