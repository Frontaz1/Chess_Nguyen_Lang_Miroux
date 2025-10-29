Class {
	#name : 'MyBlackPiece',
	#superclass : 'MyPieceColor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'converting' }
MyBlackPiece >> asColorArray [ 
	^ Color black
]

{ #category : 'testing' }
MyBlackPiece >> isBlack [
	^ true
]

{ #category : 'testing' }
MyBlackPiece >> isWhite [
	^ false
]

{ #category : 'arithmetic' }
MyBlackPiece >> negated [
   ^ MyWhitePiece new
]

{ #category : 'rendering' }
MyBlackPiece >> renderBishopOnBlackSquare: aBishop [
	^ 'v'
]

{ #category : 'rendering' }
MyBlackPiece >> renderBishopOnWhiteSquare: aBishop [
	^ 'V'
]

{ #category : 'rendering' }
MyBlackPiece >> renderKingOnBlackSquare: aKing [ 
	^ 'l'
]

{ #category : 'rendering' }
MyBlackPiece >> renderKingOnWhiteSquare: aKing [
	^ 'L'
]

{ #category : 'rendering' }
MyBlackPiece >> renderKnightOnBlackSquare: aKnight [ 
	^ 'm'
]

{ #category : 'rendering' }
MyBlackPiece >> renderKnightOnWhiteSquare: aKnight [ 
	^ 'M'
]

{ #category : 'rendering' }
MyBlackPiece >> renderPawnOnBlackSquare: aPawn [
	^ 'o'
]

{ #category : 'rendering' }
MyBlackPiece >> renderPawnOnWhiteSquare: aPawn [
	^ 'O'
]

{ #category : 'rendering' }
MyBlackPiece >> renderQueenOnBlackSquare: aQueen [
	^ 'w'
]

{ #category : 'rendering' }
MyBlackPiece >> renderQueenOnWhiteSquare: aQueen [
	^ 'W'
]

{ #category : 'rendering' }
MyBlackPiece >> renderRookOnBlackSquare: aRook [ 
	^ 't'
]

{ #category : 'rendering' }
MyBlackPiece >> renderRookOnWhiteSquare: aRook [ 
	^ 'T'
]
