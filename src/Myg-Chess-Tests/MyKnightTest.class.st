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
MyKnightTest >> testKnightMovesWithOponentObstacle [
    | knight squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (knight := MyKnight white).

    "Knights jump in L-shape"
    "They can capture enemy pieces"
    board at: 'f6' put: MyKnight black.

    squares := knight targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( d6 f6 g5 g3 f2 d2 c3 c5 ) collect: [ :name |
                    board at: name ]).
]

{ #category : 'tests' }
MyKnightTest >> testKnightMovesWithSameColorObstacle [
    | knight squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (knight := MyKnight white).

    "Knights cannot capture same-color pieces"
    board at: 'f6' put: MyKnight white.

    squares := knight targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( d6 g5 g3 f2 d2 c3 c5 ) collect: [ :name |
                    board at: name ]).
    self deny: (squares includes: (board at: 'f6')).
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
