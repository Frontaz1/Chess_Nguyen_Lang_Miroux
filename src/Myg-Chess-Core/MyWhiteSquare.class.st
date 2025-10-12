Class {
	#name : 'MyWhiteSquare',
	#superclass : 'MySquareColor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'converting' }
MyWhiteSquare >> asColor [
    ^ Color white
]

{ #category : 'testing' }
MyWhiteSquare >> isBlack [
	^ false
]

{ #category : 'testing' }
MyWhiteSquare >> isWhite [
	^ true
]

{ #category : 'rendering' }
MyWhiteSquare >> renderBishopOnSquare: aPiece [
	^aPiece renderBishopOnWhiteSquare
]

{ #category : 'rendering' }
MyWhiteSquare >> renderKingOnSquare: aPiece [
	^aPiece renderKingOnWhiteSquare
]

{ #category : 'rendering' }
MyWhiteSquare >> renderKnightOnSquare: aPiece [
	^aPiece renderKnightOnWhiteSquare
]

{ #category : 'rendering' }
MyWhiteSquare >> renderPawnOnSquare: aPiece [
	^aPiece renderPawnOnWhiteSquare
]

{ #category : 'rendering' }
MyWhiteSquare >> renderQueenOnSquare: aPiece [
	^aPiece renderQueenOnWhiteSquare
]

{ #category : 'rendering' }
MyWhiteSquare >> renderRookOnSquare: aPiece [
	^aPiece renderRookOnWhiteSquare
]
