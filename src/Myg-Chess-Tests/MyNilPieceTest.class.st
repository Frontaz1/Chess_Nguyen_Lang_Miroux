Class {
	#name : 'MyNilPieceTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyNilPieceTest >> testContentsSetterWithNullPiece [
    |aBlackSquare aWhiteSquare nilPiece text|

   nilPiece := MyNilPiece new.
	aWhiteSquare := MyChessSquare new.
	aBlackSquare := MyChessSquare new.
	
   "Text should be x if the square is black"
   aBlackSquare color: Color black.
   text := aBlackSquare contents renderPieceOn: aBlackSquare.
   self assert: text equals: 'x'.
	
	"Text should be z if the square is white"
   aWhiteSquare color: Color white.
   text := aWhiteSquare contents renderPieceOn: aWhiteSquare.
   self assert: text equals: 'z'.
]

{ #category : 'tests' }
MyNilPieceTest >> testIsPiece [ 
	"Test if the nilPiece is not a piece"
	| nilPiece |
	
   nilPiece := MyNilPiece new.
	self assert: (nilPiece isPiece not).
	
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
