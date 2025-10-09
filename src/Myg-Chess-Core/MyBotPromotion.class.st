Class {
	#name : 'MyBotPromotion',
	#superclass : 'MyPromotionPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyBotPromotion >> promotePawn: aPawn [
	^ MyQueen 
]
