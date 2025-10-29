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

	| tmp1 tmp2 |
	tmp1 := MyKnight black.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'm'
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnightOnWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyKnight black.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'M'
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightOnABlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyKnight white.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'n'
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightOnAWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyKnight white.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'N'
]
