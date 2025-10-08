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
