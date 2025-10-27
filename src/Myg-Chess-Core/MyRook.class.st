Class {
	#name : 'MyRook',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyRook >> id [
	^ 'R'
]

{ #category : 'rendering' }
MyRook >> renderPieceOn: aSquare [

	^ aSquare renderRook: self
]

{ #category : 'rendering' }
MyRook >> renderRookOnBlackSquare [
	^ color renderRookOnBlackSquare: self
]

{ #category : 'rendering' }
MyRook >> renderRookOnWhiteSquare [
	^ color renderRookOnWhiteSquare: self
]

{ #category : 'rendering' }
MyRook >> targetSquares [

	^ self upFile , self downFile , self leftFile , self rightFile
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegal: aBoolean [

	^ (self upFileLegal: aBoolean) , (self downFileLegal: aBoolean)
	  , (self leftFileLegal: aBoolean) , (self rightFileLegal: aBoolean)
]
