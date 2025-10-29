Class {
	#name : 'MyNilPieceTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyNilPieceTest >> testIsPiece [ 
	"Test if the nilPiece is not a piece"
	| nilPiece |
	
   nilPiece := MyNilPiece new.
	self assert: (nilPiece isPiece not).
	
]

{ #category : 'tests' }
MyNilPieceTest >> testNilPieceTargetSquaresLegal [
    self assert: (MyNilPiece new targetSquaresLegal: true) isEmpty.
]

{ #category : 'tests' }
MyNilPieceTest >> testRenderNilPiece [
	"render NilPiece according to its colour
	 must render 'z' if it is a white nilPiece
	 must render 'x' if it is a black nilPiece"

	| nilPiece aBlackSquare aWhiteSquare|
	nilPiece := MyNilPiece new.
	aBlackSquare := MyChessSquare new.
	aWhiteSquare := MyChessSquare new.
	aBlackSquare color: Color black.
	aWhiteSquare color: Color white.
	
	self assert: (aWhiteSquare renderPiece: nilPiece ) equals: 'z'.
	self assert: (aBlackSquare renderPiece: nilPiece ) equals: 'x'.
]
