Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> checkForPromotion [
    "Promote pawn if it reached the back rank"
    self shouldBePromoted ifTrue: [
        self board game promotePawn: self at: square
    ]
]

{ #category : 'testing' }
MyPawn >> hasReachedPromotionRank [
    "Check if pawn has reached the promotion rank"
    ^ self isWhite
        ifTrue: [square file = $8]
        ifFalse: [square file = $1]
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPawnOnBlackSquare [
	^ color renderPawnOnBlackSquare: self
]

{ #category : 'rendering' }
MyPawn >> renderPawnOnWhiteSquare [
	^ color renderPawnOnWhiteSquare: self
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'asserting' }
MyPawn >> shouldBePromoted [
    "A pawn should be promoted when it reaches the back rank"
    ^ self hasReachedPromotionRank
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
			"shouldStopCollecting pour éviter d'avoir un nilSquare"
		  (s shouldStopCollecting not) and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]
