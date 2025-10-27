# Myg Chess Game

This is a chess game for Pharo based on Bloc, Toplo and Myg.

## What is this repository really about

The goal of this repository is not to be a complete full blown game, but a good enough implementation to practice software engineering skills:
 - testing
 - reading existing code
 - refactorings
 - profiling
 - debugging

## Getting started

### Getting the code

This code has been tested in Pharo 12. You can get it by installing the following baseline code:

```smalltalk
Metacello new
	repository: 'github://Frontaz1/Chess_Nguyen_Lang_Miroux:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

### Using it

You can open the chess game using the following expression:

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```
## Katas

### Remove nil checks

**Goal:** Practice refactorings and patterns

In the game, each square has optionally a piece.
The absence of a piece is represented as a `nil`.
As any project done in stress during a short period of time (a couple of evenings when the son is sick), the original developer (Guille P) was not 100% following coding standards and quality recommendations.
We would like to clean up the game logic and remove `nil` checks using some polymorphism.
You can do it.

Questions and ideas that can help you in the process:
- How do we transform nil checks into polymorphism?
- What kind of API should you design?
- Can tests help you do it with less pain?
- Something similar happens when a pieces wants to move outside of the board, can you find it and fix it?

### Refactor piece rendering (Olivia)

**Goal:** Practice refactorings, double dispatch and table dispatch

The game renders pieces with methods that look like these:

```smalltalk
MyChessSquare >> renderKnight: aPiece

	^ aPiece isWhite
		  ifFalse: [ color isBlack
				  ifFalse: [ 'M' ]
				  ifTrue: [ 'm' ] ]
		  ifTrue: [
			  color isBlack
				  ifFalse: [ 'N' ]
				  ifTrue: [ 'n' ] ]
```
As any project done in stress during a short period of time (a couple of evenings when the son is sick), the original developer (Guille P) was not 100% following coding standards and quality recommendations.
We would like you to clean up this rendering logic and remove as much conditionals as possible, for the sake of it.
You can do it.

Questions and ideas that can help you in the process:
- Can you do an implementation with double dispatch?
- Can you do an implementation with table dispatch?
- What are the good and bad parts of them in *this scenario*? Do you understand why?

#### Design decisions
The idea for the double dispatch was to have a class of square colors and have the rendering according to the square's color. Then I added methods to simplify the method render in MyChessSquare (remove some conditionals).

![UML Design Double Dispatch](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/blob/main/uml/uml-design-double-dispatch.png)

#### Difficulties
Implementing the double dispatch was the biggest difficulty because I had to take count of the color of the pieces and the color of the squares so that the rendering is correct according to the color of the piece and the color of the square. Since I started off with not understanding that pieces have different characters according to the square's color, the double dispatch is more complexed.
![UML Difficulty Double Dispatch](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/blob/main/uml/uml-difficulties-double-dispatch.png)
Calls 1 and 2 could be simplified.

To improve and remove all the conditional with creating for each piece class, I wanted to add two subclasses according to the color, like <code>MyKing << MyWhiteKing</code> and <code>MyKing << MyBlackKing</code>. But it would mean adding 2 subclasses for each piece.

#### Tests
I tested the double dispatch with manual tests for all the pieces. I tested for each white or black piece on white or black square. For i.e, with the piece Rook :
```
MyRookTests >> testRenderWhiteRookOnAWhiteSquare
	"render rook according to its colour
	 must render 'R' if it is a white rook on a white square"

	| whiteRook aSquare |
	whiteRook := MyRook white.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: whiteRook) equals: 'R'.

MyRookTests >> testRenderWhiteRookOnABlackSquare
	"render rook according to its colour
	 must render 'r' if it is a white rook on a black square"

	| whiteRook aSquare |
	whiteRook := MyRook white.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: whiteRook) equals: 'r'.

MyRookTests >> testRenderBlackRookOnAWhiteSquare
	"render rook according to its colour
	 must render 'T' if it is a black rook on a white square"

	| blackRook aSquare |
	blackRook := MyRook black.
	
	aSquare := MyChessSquare color: MyWhiteSquare new.
	self assert: (aSquare renderPiece: blackRook) equals: 'T'.

MyRookTests >> testRenderBlackRookOnABlackSquare
	"render rook according to its colour
	 must render 't' if it is a black rook on a black square"

	| blackRook aSquare |
	blackRook := MyRook black.
	
	aSquare := MyChessSquare color: MyBlackSquare new.
	self assert: (aSquare renderPiece: blackRook) equals: 't'.
```


### Add pawn promotion

**Goal:** Practice code understanding and debugging

When pawns arrive to the back of the board, the pawn is promoted: it is transfomed into a major (queen, rook) or minor piece (knight, bishop), choice of the player.
When in an interactive UI, this requires asking the user what to do.
When in an automatic player/bot, this requires some automated decision approach.

As any *complicated* feature, the original developer (Guille P) left this for the end, and then left the project.
But you can do it.

Questions and ideas that can help you in the process:
- What tools help you finding the right place to put this new code?
- How can you find documentation and help to understand the graphical part that will implement, for example, a pop-up?
- The bot will not need a UI, how would you make it work without breaking the other existing code?

