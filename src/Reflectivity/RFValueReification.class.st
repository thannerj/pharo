"
value

Assignment:  the orginal value for before, new value for after. 

Variables: current value (same for before and after)

Message: result of the message, only availabe for *after* links.

Return: what will be returned


"
Class {
	#name : #RFValueReification,
	#superclass : #RFReification,
	#category : #'Reflectivity-Links'
}

{ #category : #'plugin interface' }
RFValueReification class >> entities [
	^{RBVariableNode. RBAssignmentNode. RBReturnNode. RBMessageNode . LiteralVariable . Slot}
]

{ #category : #'plugin interface' }
RFValueReification class >> key [
	^#value
]

{ #category : #generate }
RFValueReification >> genForInstanceVariableSlot [
	"entity in this case is the binding of the instance variable"

	^ RBMessageNode
		receiver: (RFLiteralVariableNode value: entity)
		selector: #read:
		arguments: {(RBVariableNode named: 'self')}
]

{ #category : #generate }
RFValueReification >> genForLiteralVariable [
	"entity in this case is the binding of the literal variable"
	^RFLiteralVariableNode value: entity value
]

{ #category : #generate }
RFValueReification >> genForRBAssignmentNode [
	"#value for Assignemnt is the old value, is that what we want?"
	^RBVariableNode named: entity variable name
]

{ #category : #generate }
RFValueReification >> genForRBMessageNode [
	^RBVariableNode named: #RFReifyValueVar
]

{ #category : #generate }
RFValueReification >> genForRBReturnNode [
	^RBVariableNode named: #RFReifyValueVar
]

{ #category : #generate }
RFValueReification >> genForRBVariableNode [
	entity isGlobal ifTrue: [^RFLiteralVariableNode value: entity binding value]. 
	^RBVariableNode named: entity name.
]

{ #category : #generate }
RFValueReification >> preamble: aNode [
	(aNode isKindOf: RBProgramNode) ifFalse: [ ^#() ].
	^(aNode isReturn or: [ aNode isMessage])
		ifTrue: [RFStoreIntoTempNode named: #RFReifyValueVar]
		ifFalse: [ #() ]. 
]
