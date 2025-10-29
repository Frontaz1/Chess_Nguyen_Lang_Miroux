Class {
	#name : 'MyQueenTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTests >> testIsPiece [ 
	"Test if the queenPiece is a piece"
	| queenPiece |
	
   queenPiece := MyQueen new.
	self assert: (queenPiece isPiece).
]

{ #category : 'tests' }
MyQueenTests >> testRenderBlackQueenOnABlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyQueen black.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'w'
]

{ #category : 'tests' }
MyQueenTests >> testRenderBlackQueenOnAWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyQueen black.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'W'
]

{ #category : 'tests' }
MyQueenTests >> testRenderWhiteQueenOnABlackSquare [

	| tmp1 tmp2 |
	tmp1 := MyQueen white.
	tmp2 := MyChessSquare color: MyBlackSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'q'
]

{ #category : 'tests' }
MyQueenTests >> testRenderWhiteQueenOnAWhiteSquare [

	| tmp1 tmp2 |
	tmp1 := MyQueen white.
	tmp2 := MyChessSquare color: MyWhiteSquare new.
	self assert: (tmp2 renderPiece: tmp1) equals: 'Q'
]
