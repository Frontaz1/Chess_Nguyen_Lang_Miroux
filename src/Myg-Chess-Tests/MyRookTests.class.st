Class {
	#name : 'MyRookTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyRookTests >> testId [

	self assert: MyRook new id equals: 'R'
]

{ #category : 'tests' }
MyRookTests >> testIsPiece [ 
	"Test if the rookPiece is a piece"
	| rookPiece |
	
   rookPiece := MyRook new.
	self assert: (rookPiece isPiece).
]

{ #category : 'tests' }
MyRookTests >> testMoves [

	| rook squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (rook := MyRook white).

	squares := rook targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( e5 e6 e7 e8 d4 c4 b4 a4 f4 g4 h4 e3 e2 e1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyRookTests >> testMovesWithOponentObstacle [

	| bishop squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (bishop := MyRook white).

	"Rooks don't jump above pieces"
	"But they eat pieces of the other color"
	"Let's put a black obstacle on g4, blocking the f rank"
	board at: 'g4' put: MyRook black.

	squares := bishop targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( e5 e6 e7 e8 d4 c4 b4 a4 f4 g4 e3 e2 e1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyRookTests >> testMovesWithSameColorObstacle [

	| bishop squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (bishop := MyRook white).

	"Rooks don't jump above pieces"
	"And they don't eat pieces of the same color either"
	"Let's put a white obstacle on g4, blocking the f rank"
	board at: 'g4' put: MyRook black.

	squares := bishop targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( e5 e6 e7 e8 d4 c4 b4 a4 f4 e3 e2 e1 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyRookTests >> testRenderBlackRookOnABlackSquare [
	"render knight according to its colour
	 must render 't' if it is a black rook on a black square"

	| blackRook aSquare |
	blackRook := MyRook black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackRook) equals: 't'.
]

{ #category : 'tests' }
MyRookTests >> testRenderBlackRookOnAWhiteSquare [
	"render knight according to its colour
	 must render 'T' if it is a black rook on a white square"

	| blackRook aSquare |
	blackRook := MyRook black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackRook) equals: 'T'.
]

{ #category : 'tests' }
MyRookTests >> testRenderWhiteRookOnABlackSquare [
	"render knight according to its colour
	 must render 'r' if it is a white rook on a black square"

	| whiteRook aSquare |
	whiteRook := MyRook white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whiteRook) equals: 'r'.
]

{ #category : 'tests' }
MyRookTests >> testRenderWhiteRookOnAWhiteSquare [
	"render knight according to its colour
	 must render 'R' if it is a white rook on a white square"

	| whiteRook aSquare |
	whiteRook := MyRook white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whiteRook) equals: 'R'.
]
