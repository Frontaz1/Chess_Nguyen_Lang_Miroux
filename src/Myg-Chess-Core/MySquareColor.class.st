Class {
	#name : 'MySquareColor',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'converting' }
MySquareColor >> asColor [
	self subclassResponsibility
]

{ #category : 'testing' }
MySquareColor >> isBlack [
    self subclassResponsibility
]

{ #category : 'testing' }
MySquareColor >> isWhite [
    self subclassResponsibility
]
