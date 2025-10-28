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

### Design decisions
Pour avoir un code plus propre et retirer la logique de nil qui peut vite rendre le code rempli de checks.
To solve the problem of repetitive `nil` checks, I applied the Null Object Design Pattern.

Indeed, the absence of a Piece was represented by a `nil`, so we always had to check with a 'nil' check whether our square had a Piece or not.

I created a subclass of MyPiece called MyNilPiece, which represents the absence of a real piece

This class will allow to return a `null object` with the behavior of a piece instead of a simple `nil`.

So now MyNilPiece responds to the same messages as any other piece, allowing polymorphism to replace explicit conditionals.

In the class MyPiece, we already had:
```
MyPiece >> isPiece
	^ true
```

So in MyNilPiece, I simply redefined it as:

```
MyNilPiece >> isPiece
	
	^ false
```

Now, anywhere the code previously checked `piece notNil`, we can write  `piece isPiece`.
For example
Before
```
MyPlayer >> pieces [
	^ game pieces select: [ :p | p notNil and: [ p color = self color ] ]
```

After : 
```
MyPlayer >> pieces [
	^ game pieces select: [ :p | p isPiece and: [ p color = self color ] ]
```
MyNilPiece now represents the absence of a piece, rather than nil.


Maintenant dans notre code au lieu de verifier qu'un square possède une piece nous pouvons simplement faire appel a la méthode isPiece sur n'importe quelle pièce car maintenant il n'y a plus de Nil.
Before the refactor, squares used nil to represent empty contents:

Before : 
```
MyChessSquare >> hasPiece 
	^ contents isNil not
```
After Null Object design : 
```
MyChessSquare >> hasPiece 
	^ contents isPiece
```

The utility is also that now we no longer have to check if our contents (Square content) is nil or not, our code will be able to adapt and respond to any type of piece (nil or not)
```
MyChessSquare >> contents: aPiece
...
text := contents
		        ifNil: [
			        color isBlack
				        ifFalse: [ 'z' ]
				        ifTrue: [ 'x' ] ]
		        ifNotNil: [ contents renderPieceOn: self ].
...
```

```
MyChessSquare >> contents: aPiece
...
text :=  contents renderPieceOn: self.
...
```

The renderPieceOn: method is implemented both in MyPiece and MyNilPiece, so the correct behavior occurs automatically.


Additionally, during board initialization squares, every square now starts with a MyNilPiece in their contents.

Dans l'ensemble nous voyons que grâce à ce Design, nous appliquons du polymorphisme et donc on n'a plus besoin de vérifier si nil ou non.

#### MyNilSquare 

I also add MyNilSquare, a Null Object that represents an off-board square.
Instead of returning nil when moving outside the board boundaries, the code now returns an instance of MyNilSquare.

This class safely implements all movement methods (up, down, left, right) by returning self.
This eliminates the need for repeated ifNotNil: guards in movement logic:

Before : 
```
MyPiece >> downRightDiagonalLegal: aBoolean
    ^ self collectSquares: [ :aSquare | aSquare down ifNotNil: #right ] legal: aBoolean
```
After : 
```
MyPiece >> downRightDiagonalLegal: aBoolean
    ^ self collectSquares: [ :aSquare | aSquare down right ] legal: aBoolean
```

The method shouldStopCollecting plays a similar role to isPiece, but for movement traversal.

When a piece moves along a direction (like a bishop along a diagonal), we need to know when to stop collecting squares.
Instead of checking if the square is nil or outside the board, we can simply ask each square:
```
aSquare shouldStopCollecting
```
For a normal square, this returns false.
For a MyNilSquare, it returns true, which signals that we’ve reached the board’s limit



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
I had to implement the double dispatch to render the piece according to its color and the color of the square it is in. The initial rendering contained too many conditionals.

![UML Design Double Dispatch](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/blob/main/uml/uml-design-double-dispatch.png)

I added **MySquareColor**, an abstract class, and its subclasses **MyWhiteSquare** and **MyBlackSquare**, as well as **MyPieceColor**, and its subclasses **MyWhitePiece** and **MyBlackPiece**, since the rendering depends on the piece and the color of the square. Because the initial code was not open fore extension, it has many conditionals. So breaking the code into different methods and classes can help it being more dynamic and with less conditionals. Each class handle one responsibility (Single Responsibility Principle) and we can freely add more classes, for i.e a new piece color or a new type of piece, and use polymorphism.

With this code, the square can ask the piece to render itself, and the piece can decide which symbol to render thanks to its color. Let's see how it works to render a White King on a Black Square :
- In **MyChessSquare** class, if the square is black,  **MyBlackSquare >> renderKing; aPiece** is called. It answers the question : What is the color of the square ?
- the square doesn't know which piece it is but knows himself is black, so it delegates to the piece and so call **MyKing >> renderKingOnBlackSquare**. It answers the question : Which type of piece is it ?
- the color of the piece decides on the symbol and so the method called, based on his white color, is in **MyWhitePiece >> renderKingOnBlackSquare: aKing**. It answers the question : What is the color of the piece ?

So **MySquareColor** and subclasses define how the square should influence rendering, and **MyPieceColor** and subclasses define how color changes the piece's behavior.
I also noticed that whatever color of the piece we are playing (and whatever the square's color), only the id is display on the movement record. So if a black Pawn moves to a black Square, it will only display 'P' and not 'o'. So to change it and see if the rendering with double dispatch is effective, I changed the method **MyChessGame >> recordMovementOf: aPiece to: aSquare** : 
```
recordMovementOf: aPiece to: aSquare
	"moves add: (MyMove piece: aPiece square: aSquare name)."

	| prefix movesText |
	prefix := currentPlayer isWhite
		          ifTrue: [ moveCount asString , '.' ]
		          ifFalse: [ '' ].
	moves add: prefix , ' ' , (aSquare renderPiece: aPiece) , aSquare name.       "it was aPiece id"
	....
```
> See [tag v.1.4](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/releases/tag/v.1.4)

The good part of this scenario is that we remove all the conditionals and we can add objects easily. The bad part of this double dispatch is that there are more classes and it is hard to find and to understand which method is executed.

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
#### Extension : table dispatch
With table dispatch, we have to create a table or a dictionary that associates a piece, a square and give the rendering symbol. For exemaple with King : 
```
MyKing >> renderTable
	renderTable
    ^ {
        { #whitePiece. #whiteSquare } -> [ 'K' ].
        { #whitePiece. #blackSquare } -> [ 'k' ].
        { #blackPiece. #whiteSquare } -> [ 'L' ].
        { #blackPiece. #blackSquare } -> [ 'l' ].
      } asDictionary
```
Using table dispatch allows us to have less subclasses and methods, it is more data-oriented.
Since we didn't learn how to make table dispatch yet, I didn't commit the code to avoid breaking the code again.

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

