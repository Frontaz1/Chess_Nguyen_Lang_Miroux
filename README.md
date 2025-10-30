# Myg Chess Game

This is a chess game for Pharo based on Bloc, Toplo and Myg.

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

UML : 

![UML MyNilPiece](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/blob/main/uml/uml-NullObject-MyNilPiece.png)

Before the refactor, squares used nil to represent empty contents(With no piece) :
Before : 
```
MyChessSquare >> emptyContents
	self contents: nil.
```
After : 
```
MyChessSquare >> emptyContents
	"Vide la case, on la remplace avec une NilPiece"
	self contents: MyNilPiece new.
```

Now in our code, instead of checking that a square has a piece, we can simply call `isPiece` method on any piece because now there is no more Nil.

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

The utility is also that now we no longer have to check if our contents (Square content) is nil or not, our code will be able to adapt and respond to any type of piece (MyNilPiece and the others)

Before : 
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
After : 
```
MyChessSquare >> contents: aPiece
...
text :=  contents renderPieceOn: self.
...
```

The renderPieceOn: method is implemented both in MyPiece and MyNilPiece, so the correct behavior occurs automatically.


Additionally, during board initialization squares, every square now starts with a `MyNilPiece` in their contents.

Last thing for example in MyChessSquare the method emptyContents set contents with a `MyNilPiece` and not `nil` now 

Overall, we see that thanks to this Design, we apply polymorphism and therefore we no longer need to check if nil or not.

#### MyNilSquare 

I also add MyNilSquare, a Null Object that represents an off-board square.
Instead of returning nil when moving outside the board boundaries, the code now returns an instance of MyNilSquare.

This class safely implements all movement methods (up, down, left, right) by returning self.

UML : 

![UML MyNilSquare](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/blob/main/uml/uml-NullObject-MyNilSquare.png)

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

The method shouldStopCollecting plays a similar role to isPiece, but for movement(collectSquare,targetSquare..).

When a piece moves along a direction (like a bishop along a diagonal), we need to know when to stop collecting squares.
Instead of checking if the square is nil or outside the board, we can simply ask each square:
```
aSquare shouldStopCollecting
```
For a normal square, this returns false.
For a MyNilSquare, it returns true, which signals that we’ve reached the board’s limit

To conclude this design allow to upgrade the quality of code(clean code) and delete the logic of nil check. If we dont put this design the code can be in the futur filled with too many nil checks



#### Difficulties
The part where i have the most trouble was when i implemented and tested MyNilSquare i noticed that the collectSquares:while method was not optimal because it was collecting MyNilSquare instances or piece of same color..

To solve this, i introduced the shouldStopCollecting method.

This method tells the loop when to stop collecting, preventing the algorithm from going outside the board or collecting unnecessary squares.

#### Tests 

With the new design and the introduction of MyNilPiece and MyNilSquare i think i have a correct coverage of my code and scenarios.
To ensure that the refactoring didn’t break anything, i make mainly automated tests.

After removing all nil and ifNil: checks, I systematically wrote tests to cover all possible cases where a MyNilPiece or MyNilSquare could appear.

First i make test for MyNilPiece and MyNiLSquare to know if the all the methods that a redefined or create works.

- For MyNilPiece, for example i verify that isPiece returns false, and renderPieceOn: produces the right output for empty squares.

- For MyNilSquare, i tested all directional methods (up, down, left, right) to confirm they return self and don’t break the board traversal logic.


Moreover, I also tested the methods that used MyNilSquare or MyNilPiece

- I tested that after the initialization of the chessboard, every square correctly contains a MyNilPiece by default.

- I verified that send message emptyContents correctly replaces a piece with a MyNilPiece.

- I also tested movement methods (like collectSquares: and diagonal movement) work well when they encounter a MyNilSquare.

I also do manual test to verify when we play that the targetSquare for a piece work well and the game are not broken.

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
I had to implement the double dispatch to render the piece according to its color and the color of the square it is in. The initial rendering contained too many conditionals so I prioritized remove them.

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
> NB : auto play doesn't work with this correction.

The good part of this scenario is that we remove all the conditionals and we can add objects easily. The bad part of this double dispatch is that there are more classes and it is hard to find and to understand which method is executed.

> See [tag v.1.2 for double dispatch](https://github.com/Frontaz1/Chess_Nguyen_Lang_Miroux/releases/tag/v.1.2)

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
I didn't test intermediary methods because it'd be complicated to test without knowing what message is sent.

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

### Add pawn promotion (Lan)

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

### Design Pattern used:
- Here, I implimented Strategy Pattern to execute my Promotion Strategy. This design pattern reduces code complexity and conditions. The strategy allows runtime switching while ensure not breaking the code, takes advantage of existing inherited classes and its behavior changes independently of game state.
- Besides, I have used the Templated Method for a pawn to override its father. MyPawn class here is inherited the method checkForPromotion from its abstract class MyPiece and will override it by create its own promotion. Combined with the existing codes, I have this fully UML of Promotion Pawn:
 ![chess](https://github.com/user-attachments/assets/10e3e170-1dda-4ed5-8f10-bfd19e88bdc6)

### Promotion Process
1. Pawn reachs back rank ($1 or $8) ```MyPiece >> moveTo: aSquare  ```
2. Check if promotion needed. ```MyPiece >> checkForPromotion ``` -> Pawn overrides ```MyPawn >> checkForPromotion```
3. A Pawn should be promoted. Is it reached the promotion rank? (White Pawn at $8 and Black Pawn at $1)
4. If YES, the Chess Game will promote the Pawn ``` promotePawn: aPawn at: aSquare ```
5. Ask strategy for piece type ```self promotionPawn promotePawn: aPawn``` -> Call UIPromotion ``` promotionPawn := MyUIPromotion new``` -> Returns MyQueen/MyRook/MyBishop/MyKnight
6. Create piece with correct color 
7. Put a newpiece correspondance at the current square ``` board at: aSquare name put: newPiece.```
8. Record the moves ```recordPromotion: aPawn to: newPiece at: aSquare```

### Explaining
- First, I created a new abstract class **MyPromotionPawn** for my stragegy. This class has a method **promotePawn:** which is overrided by its subclass. I created two subclasses **MyBotPromotion** and **MyUIPromotion**
```
MyBotPromotion >> promotePawn: aPawn [
	^ MyQueen
```
=> The Bot Strategy automatically returns Queen, which is the strongest piece.
```
MyUIPromotion >> promotePawn: aPawn [
	"show ui dialog and let the user choose the piece"
	| choice |
	choice := UIManager default
		chooseFrom: #(Queen Rook Knight Bishop)
		message: 'Congratulations! You have reached the last square of the chessboard.
		Choose a piece you wish to be play as:'.
		
	^ choice caseOf: { 
	[ 1 ] -> MyQueen.
	[ 2] -> MyRook.
	[ 3 ] -> MyKnight.
	[ 4 ] -> MyBishop } otherwise: MyQueen 
]
```
=> The UI Promotion shows a popup for the user to choose which piece they want to be next. There are four options: Queen/Rook/Knight/Bishop. To know how to create a user interface, I have consulted the book Pharo 9 by example, part 16.9 Interactors.
- So, when will a Pawn be promoted? When it hits the back rank. A White pawn **shouldBePromoted** when its rank is 8, on the contrary a Black Pawn **shouldBePromoted** when its rank is 1. Therefore, I move to MyPawn class and created a method check if the Pawn has reached promotion rank.
```
MyPawn >> hasReachedPromotionRank [
    "Check if pawn has reached the promotion rank"
    ^ self isWhite
        ifTrue: [square file = $8]
        ifFalse: [square file = $1]
]
```
If a Pawn **hasReachedPromotionRank**, it **shouldBePromoted**
```
MyPawn >> shouldBePromoted [
    "A pawn should be promoted when it reaches the back rank"
    ^ self hasReachedPromotionRank
]
```
- Then, I created a method **checkForPromotion** to check for promotion after each moves. The move logic is in the method **moveTo: aSquare** of MyPawn's superclass MyPiece, that means every piece can move and hit the back rank, but only the Pawn can be promoted. Here, I implimented the Template Method Design Pattern for the MyPawn class to override the method **checkForPromotion** of its superclass MyPiece
```
MyPiece >> checkForPromotion [
    "Default: do nothing. Pawns will override this"
    ^ self
]
MyPiece >> moveTo: aSquare [
...
^ self checkForPromotion
]
```
MyPawn overrides this
```
MyPawn >> checkForPromotion [
    "Promote pawn if it reached the back rank"
    self shouldBePromoted ifTrue: [
        self board game promotePawn: self at: square
    ]
]
```
### Extension: promotePawn: aPawn at: aSquare
```
MyChessGame >> promotePawn: aPawn at: aSquare [
	...
    pieceClass := self promotionPawn promotePawn: aPawn.
    ....
```
With the message `self promotionPawn promotePawn: aPawn.`, we call a **promotionPawn** to take its strategy (Bot or UI). This is the extensibility point, which means we can add more strategy after to the Strategy Class (here is the MyPromotionPawn class) and call to get it without breaking **promotePawn: aPawn at: aSquare** method

- To make a ChessGame can call a Promotion Strategy, I have to initialize and create methods getter/setter for a Promotion in the MyChessGame. I set default Promotion here is MyUIPromotion.
```
MyChessGame >> initialize [
...
promotionPawn := MyUIPromotion new
]
MyChessGame >> promotionPawn [
	^ promotionPawn ifNil: [ promotionPawn := MyUIPromotion new ]
]

{ #category : 'accessing' }
MyChessGame >> promotionPawn: aStrategy [
	promotionPawn := aStrategy	
]
```
- Finally, I create **recordPromotion: aPawn to: newPiece at: aSquare** to record all the moves of my promotion. This method is based on this existed method **recordMovementOf: aPiece to: aSquare**
- I also add two shortcuts: **useBotPromotion** and **useUIPromotion** for easier calling in Playground.
### Running the Bot promotion (because the default promotion is UIPromotion)
```smalltalk
board := MyChessGame freshGame.
board useBotPromotion.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```

### Difficulites
- The hardest part for me is to read the code and to find the logic moving of aPiece, aPawn, the logic initializing a ChessGame. 
- I have read the expression to open the board game, then take a look at the MyChessGame class, find the move logic method and draw a link to what makes sense. If a pawn moves, what happened? What is the condition for promotion? Of WhitePawn? Of BlackPawn?
- Also, I have to read documents to understand what is a **Strategy Pattern** and **Template Method**. Why it is better using Strategy Pattern for a promotion pawn than a Template Method? If I used Template Method what happened? 
- With the UIPromotion, I have read an UI specified book like **The Spec UI framework** but finally I found the exemple in **Pharo 9 by Example** is enough and better to apply for my case.

### Tests
These are some methods in class MyPawnPromotionTest
- testDefaultPromotion -> returns MyUIPromotion
- testMultiplesPromotionsInABoard -> 2 pieces can be promoted simultaneously in a board
- testSetUpBotPromotion -> board useBotPromotion -> use Bot Promotion at first.
- testSwitchingPromotion -> check if MyUIPromotion as default and after that we can switch to MyBotPromotion
- testWhitePawnAtRank7HasNotReachedPromotionRank -> Pawn at rank 7 has not meet the condition to be promoted
- testWhitePawnAtRank8HasReachedPromotionRank -> Pawn at rank 8 has meet the condition to be promoted
- testWhitePawnAtRank8ShouldBePromoted -> a Pawn should be promoted when it reaches the back rank














