Class {
	#name : 'MyPieceColor',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyPieceColor >> isBlack [
	self subclassResponsibility 
]

{ #category : 'testing' }
MyPieceColor >> isWhite [
	self subclassResponsibility 
]

{ #category : 'rendering' }
MyPieceColor >> renderKingOnBlackSquare: aKing [
	self subclassResponsibility
]

{ #category : 'rendering' }
MyPieceColor >> renderKingOnWhiteSquare: aKing [
	self subclassResponsibility
]
