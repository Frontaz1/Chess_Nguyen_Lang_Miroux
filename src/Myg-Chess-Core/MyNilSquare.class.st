Class {
	#name : 'MyNilSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyNilSquare >> color [
	^nil
]

{ #category : 'accessing' }
MyNilSquare >> contents [
	^MyNilPiece new.
]

{ #category : 'instance creation' }
MyNilSquare >> down [
	"MyNilSquare don't move"
	^self
]

{ #category : 'testing' }
MyNilSquare >> hasPiece [
	^true
]

{ #category : 'instance creation' }
MyNilSquare >> left [
	"MyNilSquare don't move"
	^self
]

{ #category : 'instance creation' }
MyNilSquare >> right [
	"MyNilSquare don't move"
	^self
]

{ #category : 'asserting' }
MyNilSquare >> shouldStopCollecting [
^ true
]

{ #category : 'instance creation' }
MyNilSquare >> up [
	"MyNilSquare don't move"
	^self
]
