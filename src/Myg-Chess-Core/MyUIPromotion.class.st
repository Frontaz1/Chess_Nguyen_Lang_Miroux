Class {
	#name : 'MyUIPromotion',
	#superclass : 'MyPromotionPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyUIPromotion >> promotePawn: aPawn [
	"show ui dialog and let the user choose the piece"
	UIManager default
		chooseFrom: #(Queen Rook Knight Bishop)
		message: 'Congratulations! You have reached the last square of the chessboard.
		Choose a piece you wish to be play as:'.
		
	^ self caseOf: { 
	[ 1 ] -> MyQueen.
	[ 2] -> MyRook.
	[ 3 ] -> MyKnight.
	[ 4 ] -> MyBishop } otherwise: MyQueen 
]
