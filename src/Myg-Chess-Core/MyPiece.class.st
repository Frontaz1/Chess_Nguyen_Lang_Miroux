Class {
	#name : 'MyPiece',
	#superclass : 'Object',
	#instVars : [
		'color',
		'square'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPiece class >> black [

	^ self new
		  color: Color black;
		  yourself
]

{ #category : 'constants' }
MyPiece class >> white [

	^ self new
		  color: Color white;
		  yourself
]

{ #category : 'as yet unclassified' }
MyPiece >> attackingSquares [
	"return the squares that the piece can attack, for now it is only legalTargetSquares"
	^ self legalTargetSquares
]

{ #category : 'path commands' }
MyPiece >> board [

	^ square board
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock [
	"run through squares"
	^ self collectSquares: aBlock legal: false
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock legal: shouldBeLegal [
	"run through squares according to a direction, ignore squares where same colored pieces are on"
	^ self collectSquares: aBlock while: [ :aSquare |
		  aSquare notNil and: [ shouldBeLegal ==> aSquare hasPiece not ] ]
]

{ #category : 'rendering' }
MyPiece >> collectSquares: collectBlock while: untilBlock [
	"run through squares, move forward and stop when meet a busy square"
	| targets next |
	targets := OrderedCollection new.

	"Collect up right"
	next := square.
	[ untilBlock value: (next := collectBlock value: next) ]
		whileTrue: [ targets add: next ].

	"If we can it the next piece, then add it too"
	(next notNil and: [ next contents color ~= color ]) ifTrue: [ targets add: next ].

	^ targets
]

{ #category : 'accessing' }
MyPiece >> color [

	^ color
]

{ #category : 'accessing' }
MyPiece >> color: aColor [

	color := aColor
]

{ #category : 'rendering' }
MyPiece >> downFile [
	"run through squares under the piece"
	^ self downFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> downFileLegal: aBoolean [
	"run through squares under the piece and apply filter legal"
	^ self collectSquares: [ :aSquare | aSquare down ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonal [
	"run through squares under the piece - diagonally to the left"
	^ self downLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonalLegal: aBoolean [
	"run through squares under the piece - diagonally to the left - and apply filter legal"
	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #left ]
		  legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonal [
	"run through squares under the piece - diagonally to the right"
	^ self downRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonalLegal: aBoolean [
	"run through squares under the piece - diagonally to the right - and apply filter legal"
	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #right ]
		  legal: aBoolean
]

{ #category : 'accessing' }
MyPiece >> id [

	^ 'Q'
]

{ #category : 'testing' }
MyPiece >> isKing [
	
	^ false
]

{ #category : 'testing' }
MyPiece >> isPiece [
	
	^ true
]

{ #category : 'testing' }
MyPiece >> isWhite [
	
	^ color isBlack not
]

{ #category : 'rendering' }
MyPiece >> leftFile [
	"run through squares on the left of the piece"
	^ self leftFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> leftFileLegal: aBoolean [
	"run through squares on the left of the piece and apply filter legal"
	^ self collectSquares: [ :aSquare | aSquare left ] legal: aBoolean
]

{ #category : 'path commands' }
MyPiece >> legalTargetSquares [
	"return the squares where the piece can legally move"
	^ self targetSquaresLegal: true
]

{ #category : 'path commands' }
MyPiece >> moveTo: aSquare [
	"check if the target is in legalTargetSquares
	 move the piece, empty old square and put piece on new square"
	(self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

	square emptyContents.
	square := aSquare.
	aSquare contents: self
]

{ #category : 'rendering' }
MyPiece >> rightFile [
	"run through squares on the right of the piece"
	^ self rightFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> rightFileLegal: aBoolean [
	"run through squares to the right of the piece and apply filter legal"
	^ self collectSquares: [ :aSquare | aSquare right ] legal: aBoolean
]

{ #category : 'accessing' }
MyPiece >> square [
	^ square
]

{ #category : 'accessing' }
MyPiece >> square: aMyChessSquare [ 
	square := aMyChessSquare
]

{ #category : 'rendering' }
MyPiece >> targetSquares [
	"return the squares the piece can go to move or attack - without legal filter"
	^ self targetSquaresLegal: false
]

{ #category : 'rendering' }
MyPiece >> targetSquaresLegal: aBoolean [
	"see subclasses"
	self subclassResponsibility
]

{ #category : 'rendering' }
MyPiece >> upFile [
	"run through squares above the piece"
	^ self upFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> upFileLegal: aBoolean [
	"run through squares above the piece and apply filter legal"
	^ self collectSquares: [ :aSquare | aSquare up ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonal [
	"run through squares above the piece - diagonally to the left"
	^ self upLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonalLegal: aBoolean [
	"run through squares above the piece - diagonally to the left - and apply filter legal"
	^ self collectSquares: [ :aSquare | aSquare up ifNotNil: #left ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonal [
	"run through squares above the piece - diagonally to the right"
	^ self upRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonalLegal: aBoolean [
	"run through squares above the piece - diagonally to the right - and apply filter legal"
	^ self
		  collectSquares: [ :aSquare | aSquare up ifNotNil: #right ]
		  legal: aBoolean
]
