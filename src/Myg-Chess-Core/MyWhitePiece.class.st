Class {
	#name : 'MyWhitePiece',
	#superclass : 'MyPieceColor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'converting' }
MyWhitePiece >> asColor [
	^ Color white
]

{ #category : 'testing' }
MyWhitePiece >> isBlack [
	^ false
]

{ #category : 'testing' }
MyWhitePiece >> isWhite [
	^ true
]

{ #category : 'arithmetic' }
MyWhitePiece >> negated [
   ^ MyBlackPiece new
]

{ #category : 'rendering' }
MyWhitePiece >> renderBishopOnBlackSquare: aBishop [
	^ 'b'
]

{ #category : 'rendering' }
MyWhitePiece >> renderBishopOnWhiteSquare: aBishop [
	^ 'B'
]

{ #category : 'rendering' }
MyWhitePiece >> renderKingOnBlackSquare: aKing [
	^ 'k'
]

{ #category : 'rendering' }
MyWhitePiece >> renderKingOnWhiteSquare: aKing [
	^ 'K'
]

{ #category : 'rendering' }
MyWhitePiece >> renderKnightOnBlackSquare: aKnight [
	^ 'n'
]

{ #category : 'rendering' }
MyWhitePiece >> renderKnightOnWhiteSquare: aKnight [
	^ 'N'
]

{ #category : 'rendering' }
MyWhitePiece >> renderPawnOnBlackSquare: aPawn [
	^ 'p'
]

{ #category : 'rendering' }
MyWhitePiece >> renderPawnOnWhiteSquare: aPawn [
	^ 'P'
]

{ #category : 'rendering' }
MyWhitePiece >> renderQueenOnBlackSquare: aQueen [
	^ 'q'
]

{ #category : 'rendering' }
MyWhitePiece >> renderQueenOnWhiteSquare: aQueen [
	^ 'Q'
]

{ #category : 'rendering' }
MyWhitePiece >> renderRookOnBlackSquare: aRook [
	^ 'r'
]

{ #category : 'rendering' }
MyWhitePiece >> renderRookOnWhiteSquare: aRook [
	^ 'R'
]
