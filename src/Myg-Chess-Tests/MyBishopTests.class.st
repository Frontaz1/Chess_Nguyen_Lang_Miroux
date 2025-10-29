Class {
	#name : 'MyBishopTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyBishopTests >> testId [

	self assert: MyBishop new id equals: 'B'
]

{ #category : 'tests' }
MyBishopTests >> testIsPiece [ 
	"Test if the bishopPiece is a piece"
	| bishopPiece |
	
   bishopPiece := MyBishop new.
	self assert: (bishopPiece isPiece).
]

{ #category : 'tests' }
MyBishopTests >> testMoves [

	| bishop squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (bishop := MyBishop white).

	squares := bishop targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( f5 g6 h7 f3 g2 h1 d5 c6 b7 a8 d3 c2 b1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyBishopTests >> testMovesWithOponentObstacle [

	| bishop squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (bishop := MyBishop white).

	"Bishops don't jump above pieces"
	"But they eat pieces of the other color"
	"Let's put a black obstacle on g6, blocking the f5-h7 diagonal"
	board at: 'g6' put: MyBishop black.

	squares := bishop targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( f5 g6 f3 g2 h1 d5 c6 b7 a8 d3 c2 b1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyBishopTests >> testMovesWithSameColorObstacle [

	| bishop squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (bishop := MyBishop white).

	"Bishops don't jump above pieces"
	"And they don't eat pieces of the same color either"
	"Let's put a white obstacle on g6, blocking the f5-h7 diagonal"
	board at: 'g6' put: MyBishop white.

	squares := bishop targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( f5 f3 g2 h1 d5 c6 b7 a8 d3 c2 b1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyBishopTests >> testRenderBlackBishopOnBlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyBishop black.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'v'
]

{ #category : 'tests' }
MyBishopTests >> testRenderBlackBishopOnWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyBishop black.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'V'
]

{ #category : 'tests' }
MyBishopTests >> testRenderWhiteBishopOnBlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyBishop white.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'b'
]

{ #category : 'tests' }
MyBishopTests >> testRenderWhiteBishopOnWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyBishop white.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'B'
]
