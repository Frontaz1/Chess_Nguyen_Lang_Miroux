Class {
	#name : 'MyPawnPromotionTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnPromotionTest >> testBlackPawnAtRank1HasReachedPromotionRank [
    "Black Pawn at rank 1 has reached promotion rank"
    | blackPawn board square |
    board := MyChessBoard empty.
    board initializeSquares.
    blackPawn := MyPawn black.
    square := board at: 'e1'.
    board at: 'e1' put: blackPawn.
    
    self assert: blackPawn hasReachedPromotionRank
]

{ #category : 'tests' }
MyPawnPromotionTest >> testBotPromotionReturnsQueen [
	|promotion pawn check|
	promotion := MyBotPromotion new.
	pawn := MyPawn white.
	
	check := promotion promotePawn: pawn.
	
	self assert: check equals: MyQueen

]

{ #category : 'tests' }
MyPawnPromotionTest >> testDefaultPromotion [
|board|
board:= MyChessGame freshGame.

	
	self assert: board promotionPawn class equals: MyUIPromotion.


]

{ #category : 'tests' }
MyPawnPromotionTest >> testMultiplesPromotionsInABoard [
    "Same promotion can be reused many times in a board"
    | promotion pawn1 pawn2 result1 result2 |
    promotion := MyBotPromotion new.
    pawn1 := MyPawn white.
    pawn2 := MyPawn black.
    
    result1 := promotion promotePawn: pawn1.
    result2 := promotion promotePawn: pawn2.
    
    self assert: result1 equals: MyQueen.
    self assert: result2 equals: MyQueen
]

{ #category : 'tests' }
MyPawnPromotionTest >> testSetUpBotPromotion [
|board|

board:= MyChessGame freshGame.

board useBotPromotion.
	
	self assert: board promotionPawn class equals: MyBotPromotion.


]

{ #category : 'tests' }
MyPawnPromotionTest >> testSwitchingPromotion [
    | board |
    board:= MyChessGame freshGame.
    
    "MyUIPromotion as default"
    self assert: board promotionPawn class equals: MyUIPromotion .
    
    "Switching to MyBotPromotion"
    board useBotPromotion.
    self assert: board promotionPawn class equals: MyBotPromotion .
]

{ #category : 'tests' }
MyPawnPromotionTest >> testWhitePawnAtRank7HasNotReachedPromotionRank [
    "White Pawn at rank 7 not yet promotion rank"
    | whitePawn board square |
    board := MyChessBoard empty.
    board initializeSquares.
    whitePawn := MyPawn white.
    square := board at: 'e7'.
    board at: 'e7' put: whitePawn.
    
    self deny: whitePawn hasReachedPromotionRank
]

{ #category : 'tests' }
MyPawnPromotionTest >> testWhitePawnAtRank8HasReachedPromotionRank [
    | whitePawn board square |
    board := MyChessBoard empty.
    board initializeSquares.
    whitePawn := MyPawn white.
    square := board at: 'e8'.
    board at: 'e8' put: whitePawn.
    
    self assert: whitePawn hasReachedPromotionRank
]

{ #category : 'tests' }
MyPawnPromotionTest >> testWhitePawnAtRank8ShouldBePromoted [
    "White pawn at rank 8 must be promoted"
    | whitePawn board |
    board := MyChessBoard empty.
    board initializeSquares.
    whitePawn := MyPawn white.
    board at: 'a8' put: whitePawn.
    
    self assert: whitePawn shouldBePromoted
]
