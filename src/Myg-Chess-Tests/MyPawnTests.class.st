Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testIsPiece [ 
	"Test if the pawnPiece is a piece"
	| pawnPiece |
	
   pawnPiece := MyPawn new.
	self assert: (pawnPiece isPiece).
]

{ #category : 'tests' }
MyPawnTests >> testRenderBlackPawnOnABlackSquare [
	"render pawn according to its colour
	 must render 'o' if it is a black pawn on a black square"

	| blackPawn aSquare |
	blackPawn := MyPawn black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackPawn) equals: 'o'.
]

{ #category : 'tests' }
MyPawnTests >> testRenderBlackPawnOnAWhiteSquare [
	"render pawn according to its colour
	 must render 'O' if it is a black pawn on a white square"

	| blackPawn aSquare |
	blackPawn := MyPawn black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackPawn) equals: 'O'.
]

{ #category : 'tests' }
MyPawnTests >> testRenderWhitePawnOnAWhiteSquare [
	"render pawn according to its colour
	 must render 'p' if it is a white pawn on a black square"

	| whitePawn aSquare |
	whitePawn := MyPawn white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whitePawn) equals: 'p'.
]
