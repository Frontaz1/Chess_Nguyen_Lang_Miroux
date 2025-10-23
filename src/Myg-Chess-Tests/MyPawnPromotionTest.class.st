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
    "White pawn in rank 8 has reached promotion rank"
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
