Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testIsPiece [ 
	"Test if the pawnPiece is a piece"
	| pawnPiece |
	
   pawnPiece := MyPawn new.
	self assert: (pawnPiece isPiece).
]

{ #category : 'tests' }
MyPawnTests >> testPawnMovesForward [
    | board pawn squares |
    board := MyChessBoard empty.
    board at: 'e2' put: (pawn := MyPawn white).
    squares := pawn targetSquaresLegal: true.
    self assert: (squares anySatisfy: [ :sq | sq = (board at: 'e3') ]).
]

{ #category : 'tests' }
MyPawnTests >> testPawnMovesWithOponentObstacle [
"For the moment the legalMove for a pawn its just to go forward, we need to refactor the method to catch opponent pawn diagonnaly"
    | pawn squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).

    "Pawns move forward"
    board at: 'e5' put: MyPawn black.

    squares := pawn targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( e5) collect: [ :name | board at: name ]).
]

{ #category : 'tests' }
MyPawnTests >> testPawnMovesWithSameColorObstacle [
    | pawn squares board |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).

    "We cant capture same color piece"
    board at: 'd5' put: MyPawn white.
    board at: 'f5' put: MyPawn white.

    squares := pawn targetSquaresLegal: true.
    self
        assertCollection: squares
        includesAll:
            (#( e5 ) collect: [ :name | board at: name ]).
    self deny: (squares includes: (board at: 'd5')).
    self deny: (squares includes: (board at: 'f5')).
]

{ #category : 'tests' }
MyPawnTests >> testRenderBlackPawnOnABlackSquare [
	"render pawn according to its colour
	 must render 'o' if it is a black pawn on a black square"

	| blackPawn aSquare |
	blackPawn := MyPawn black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackPawn) equals: 'o'.
]

{ #category : 'tests' }
MyPawnTests >> testRenderBlackPawnOnAWhiteSquare [
	"render pawn according to its colour
	 must render 'O' if it is a black pawn on a white square"

	| blackPawn aSquare |
	blackPawn := MyPawn black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackPawn) equals: 'O'.
]

{ #category : 'tests' }
MyPawnTests >> testRenderWhitePawnOnABlackSquare [
	"render pawn according to its colour
	 must render 'p' if it is a white pawn on a black square"

	| whitePawn aSquare |
	whitePawn := MyPawn white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whitePawn) equals: 'p'.
]

{ #category : 'tests' }
MyPawnTests >> testRenderWhitePawnOnAWhiteSquare [
	"render pawn according to its colour
	 must render 'p' if it is a white pawn on a white square"

	| whitePawn aSquare |
	whitePawn := MyPawn white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whitePawn) equals: 'P'.
]
