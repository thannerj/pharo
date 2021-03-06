"
SUnit tests for class RunArray
"
Class {
	#name : #RunArrayTest,
	#superclass : #TestCase,
	#category : #'Text-Tests-Base'
}

{ #category : #'tests - instance creation' }
RunArrayTest >> testANewRunArrayIsEmpty [

	| t |
	t := RunArray new.
	self assert: t isEmpty 

]

{ #category : #'tests - accessing' }
RunArrayTest >> testAt [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	self assert: (array at: 3) equals: 2.
	
	array at: 3 put: 5.
	self assert: (array at: 3) equals: 5

]

{ #category : #'tests - accessing' }
RunArrayTest >> testAtPut [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	
	array at: 3 put: 5.
	self assert: array asArray equals: #(2 2 5 2 2).
	
	array at: 1 put: 1.
	self assert: array asArray equals: #(1 2 5 2 2)
]

{ #category : #'tests - accessing' }
RunArrayTest >> testAtPut2 [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	
	self should: [array at: 0 put: 5] raise: Error.
	self should: [array at: 6 put: 5] raise: Error.
	self should: [array at: $b put: 5] raise: Error
]

{ #category : #'tests - accessing' }
RunArrayTest >> testFirst [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	self assert: array first equals: 2.
	
	array := 'abcd' as: RunArray.
	self assert: array first equals: $a
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testIsSelfEvaluating [
	| array array2 |
	array := RunArray new: 5 withAll: 2.
	self assert: array isSelfEvaluating.
	array2 := RunArray new: 5 withAll: Object new.
	array2 isSelfEvaluating ifTrue: [self
		assert: (self class compiler evaluate: array2 printString) = array2
		description: 'a self evaluating should evaluate as self']
]

{ #category : #'tests - accessing' }
RunArrayTest >> testLast [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	self assert: array last equals: 2.
	
	array := 'abcd' as: RunArray.
	self assert: array last equals: $d
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testNew [
	
	| array |
	array := RunArray new.
	self assert: array size equals: 0
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testNewFromArray [
	
	| array |
	array := RunArray newFrom: #($a $b $b $b $b $c $c $a).
	self assert: array size equals: 8.
	self assert: array asArray equals: #($a $b $b $b $b $c $c $a)
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testNewFromString [
	
	| array |
	array := RunArray newFrom: 'abbbbcca'.
	self assert: array size equals: 8.
	self assert: array asArray equals: #($a $b $b $b $b $c $c $a)
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testNewWithAll [
	
	| array |
	array := RunArray new: 5 withAll: 2.
	self assert: array size equals: 5.
	self assert: array asArray equals: #(2 2 2 2 2)
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testNewWithSize [
	|array|
	array := RunArray new: 5.
	self assert: array size equals: 5.
	1 to: 5 do: [:index | self assert: (array at: index) isNil]
]

{ #category : #'tests - accessing' }
RunArrayTest >> testRunLengthAt [
	
	| array |
	array := #($a $b $b $c $c $c $d $d) as: RunArray.
	self assert: (array runLengthAt: 1) equals: 1.
	self assert: (array runLengthAt: 2) equals: 2.
	self assert: (array runLengthAt: 3) equals: 1.
	self assert: (array runLengthAt: 4) equals: 3.
	self assert: (array runLengthAt: 5) equals: 2.
	self assert: (array runLengthAt: 6) equals: 1.
	self assert: (array runLengthAt: 7) equals: 2.
	self assert: (array runLengthAt: 8) equals: 1.
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testRunsValues [
	
	| array |
	array := RunArray runs: #(1 4 2 1) values: #($a $b $c $a).
	self assert: array size equals: 8.
	self assert: array asArray equals: #($a $b $b $b $b $c $c $a)
]

{ #category : #'tests - instance creation' }
RunArrayTest >> testScanFromANSICompatibility [
 
	RunArray scanFrom: '()f1dNumber new;;' readStream.
	RunArray scanFrom: '()a1death;;' readStream.
	RunArray scanFrom: '()F1death;;' readStream
]

{ #category : #'tests - accessing' }
RunArrayTest >> testWithStartStopAndValueDo [
	
	| array elements startStops |
	array := #($a $b $b $c $c $c $d $d) as: RunArray.
	elements := OrderedCollection new.
	startStops := OrderedCollection new.
	array withStartStopAndValueDo: [:start :stop :value | elements add: value. startStops add: start->stop].
	
	self assert: elements asArray equals: #($a $b  $c  $d).
	self assert: startStops asArray equals: {1->1 . 2->3 . 4->6 . 7->8}
]
