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
