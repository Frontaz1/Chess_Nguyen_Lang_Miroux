Class {
	#name : 'MyKnight',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyKnight >> id [
	
	^ 'N'
]

{ #category : 'rendering' }
MyKnight >> renderKnightOnBlackSquare [

	^ self isWhite
		ifTrue: [ 'n' ]
		ifFalse: [ 'm' ]
]

{ #category : 'rendering' }
MyKnight >> renderKnightOnWhiteSquare [
	^ self isWhite
		ifTrue: [ 'N' ]
		ifFalse: [ 'M' ]
]

{ #category : 'rendering' }
MyKnight >> renderPieceOn: aSquare [

	^ aSquare renderKnight: self
]

{ #category : 'rendering' }
MyKnight >> targetSquaresLegal: aBoolean [
^ {
        (square right right) up.
        (square right right) down.
        (square left left) up.
        (square left left) down.
        (square up up) left.
        (square up up) right.
        (square down down) left.
        (square down down) right
    }
    select: [ :s |
		"shouldStopCollecting pour éviter d'avoir un nilSquare"
		 (s shouldStopCollecting not) and:
        [ s hasPiece not or: [ s contents color ~= color ] ] ].
]
