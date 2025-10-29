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
MyKingTest >> testIsPiece [ 
	"Test if the kingPiece is a piece"
	| kingPiece |
	
   kingPiece := MyKing new.
	self assert: (kingPiece isPiece).
]

{ #category : 'tests' }
MyKingTest >> testKingMovesWithOponentObstacle [
"We cannot target e5 because its a threathened square (We need to modify this behavior to allowed the king to eat e5)"
    | king squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (king := MyKing white).

    "King moves one square in any direction"
    "Can capture enemy pieces"
    board at: 'e5' put: MyRook black.

    squares := king targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( f4 d3 f4 e3 f3 ) collect: [ :name |
                    board at: name ]).
]

{ #category : 'tests' }
MyKingTest >> testKingMovesWithSameColorObstacle [
    | king squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (king := MyKing white).

    "King cannot move onto squares occupied by same-color pieces"
    board at: 'e5' put: MyRook white.

    squares := king targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( d5 f5 d4 f4 d3 e3 f3 ) collect: [ :name |
                    board at: name ]).
    self deny: (squares includes: (board at: 'e5')).
]

{ #category : 'tests' }
MyKingTest >> testRenderBlackKingOnABlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyKing black.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'l'
]

{ #category : 'tests' }
MyKingTest >> testRenderBlackKingOnAWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyKing black.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'L'
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingOnABlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyKing white.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'k'
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingOnAWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyKing white.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'K'
]
