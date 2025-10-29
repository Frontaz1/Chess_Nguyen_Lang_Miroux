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
