Class {
	#name : 'MyNilPiece',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyNilPiece >> isPiece [
	^false
]

{ #category : 'rendering' }
MyNilPiece >> renderPieceOn: aSquare [
	"Retourne le texte à afficher pour une case vide"
    ^ aSquare color isBlack 
					ifTrue: ['x'] ifFalse: ['z'].
]
