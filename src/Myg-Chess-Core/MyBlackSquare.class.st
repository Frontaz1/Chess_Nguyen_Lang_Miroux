Class {
	#name : 'MyBlackSquare',
	#superclass : 'MySquareColor',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'converting' }
MyBlackSquare >> asColor [
    ^ Color black
]

{ #category : 'testing' }
MyBlackSquare >> isBlack [ 
	^ true
]

{ #category : 'testing' }
MyBlackSquare >> isWhite [
	^ false
]

{ #category : 'rendering' }
MyBlackSquare >> renderBishopOnSquare: aPiece [
	^aPiece renderBishopOnBlackSquare
]

{ #category : 'rendering' }
MyBlackSquare >> renderKingOnSquare: aPiece [
	^aPiece renderKingOnBlackSquare
]

{ #category : 'rendering' }
MyBlackSquare >> renderKnightOnSquare: aPiece [
	^aPiece renderKnightOnBlackSquare
]

{ #category : 'rendering' }
MyBlackSquare >> renderPawnOnSquare: aPiece [
	^aPiece renderPawnOnBlackSquare
]

{ #category : 'rendering' }
MyBlackSquare >> renderQueenOnSquare: aPiece [
	^aPiece renderQueenOnBlackSquare
]

{ #category : 'rendering' }
MyBlackSquare >> renderRookOnSquare: aPiece [
	^aPiece renderRookOnBlackSquare
]
