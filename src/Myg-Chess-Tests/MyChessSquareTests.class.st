Class {
	#name : 'MyChessSquareTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTests >> testEmptyContents [

	| square pawn board|
	board := MyChessBoard empty.
	square := MyChessSquare color: MyWhiteSquare new.
	pawn := MyPawn white.
	board at: 'e4' put: pawn.
	square := board at: 'e4'.
	
	"The square content is a pawn"
	square contents: pawn.
	self assert: square hasPiece.
	
	"If we call emprtContents the content of the square should be MyNilPiece"
	square emptyContents.
	self assert: square contents class equals: MyNilPiece
]
