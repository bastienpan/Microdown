"
I am intended to provide arguments to annotations, codeblocks and environments. 

My syntax is of the following form:

- ` ` defaultArg->initialValue, no other arguments. 
- `value` defaultArg->value, no otherarguments. 
- `key=arg[&key=arg]*`, defaultArg->initialValue, but arguments.
- `value|key=arg[&key=arg]*` defaultArg->value, and arguments.
"
Class {
	#name : #MicArgumentList,
	#superclass : #OrderedDictionary,
	#instVars : [
		'defaultArg',
		'initialValue'
	],
	#category : #'Microdown-Parser'
}

{ #category : #'instance creation' }
MicArgumentList class >> split: aString [
	^ self new 
		from: aString; 
		yourself 
]

{ #category : #'instance creation' }
MicArgumentList class >> split: aString defaultArg: defArg [
	^ self new
		defaultArg: defArg;
		from: aString;
		yourself
]

{ #category : #'instance creation' }
MicArgumentList class >> split: aString defaultArg: defArg defaultValue: defValue [
	^ self new
		defaultArg: defArg;
		at: defArg put: defValue;
		initialValue: defValue;
		from: aString; 
		yourself
]

{ #category : #'instance creation' }
MicArgumentList class >> withStream: aStream [
	^ self split: aStream contents.
]

{ #category : #'instance creation' }
MicArgumentList class >> withString: aString [
	^ self split: aString 
]

{ #category : #accessing }
MicArgumentList >> defaultArg [

	^ defaultArg ifNil: [ defaultArg := #defaultArg ]
]

{ #category : #accessing }
MicArgumentList >> defaultArg: anObject [

	defaultArg := anObject
]

{ #category : #accessing }
MicArgumentList >> defaultValue [
	^ self at: defaultArg ifAbsent: [ initialValue  ]
]

{ #category : #initialization }
MicArgumentList >> from: fullString [
	"I am the 'parser' of the argument splitter"
	| barSplit |
	fullString isEmpty ifTrue: [ ^ self ].
	(fullString intersection: '|=&') isEmpty 
		ifTrue: [ ^self setDefaultNoArguments: fullString  ].
	barSplit := fullString splitOn: $|.
	barSplit size > 1
		ifTrue: [ ^ self setDefaultAndArguments: barSplit  ].
	self setNoDefaultButArguments: fullString
	
]

{ #category : #testing }
MicArgumentList >> hasNonDefaultArguments [
	"has changed #defaultArg or has other keys"
	^ self hasNonDefaultValue or: [ (self keys copyWithout: self defaultArg ) notEmpty  ]
		
]

{ #category : #testing }
MicArgumentList >> hasNonDefaultValue [
	"return true if the default arg was given a value"
	^ self defaultValue notNil and: [ self defaultValue ~= initialValue  ]
]

{ #category : #accessing }
MicArgumentList >> initialValue: anObject [

	initialValue := anObject
]

{ #category : #copying }
MicArgumentList >> justTheArguments [
	^ self copy 
		removeKey: defaultArg ifAbsent: [ ]; 
		yourself 
]

{ #category : #printing }
MicArgumentList >> printOn: aStream [
	|argKeys|
	self hasNonDefaultValue 
		ifTrue:[
			aStream nextPutAll: self defaultValue.
			argKeys := self keys copyWithout: self defaultArg.
			argKeys ifNotEmpty: [aStream nextPut: $|]]
		ifFalse: [argKeys := self keys].
	aStream nextPutAll: ((argKeys collect: [:k| k,'=',(self at:k)]) joinUsing: '&')
]

{ #category : #printing }
MicArgumentList >> printString [
	^ String streamContents: [ :stream | self printOn: stream ]
]

{ #category : #parsing }
MicArgumentList >> setDefaultAndArguments: barSplit [
	"barSplit is two strings, first assumed to be just a value, second to be arguments"
	|value|
	value := barSplit first trim.
	self at: self defaultArg put: value.
	self setNoDefaultButArguments: barSplit second
]

{ #category : #parsing }
MicArgumentList >> setDefaultNoArguments: fullString [
	"fullstring is just a name (containing no arguments)
	It is interpreted as both a name, and as an argument with no value"
	|value|
	value := fullString trim.
	self at: self defaultArg put: value
]

{ #category : #parsing }
MicArgumentList >> setNoDefaultButArguments: string [
	"string is assumed to be on the form key=value&key=value"
	| pairs |
	pairs := string splitOn: $&.
	pairs do: [ :p | |keyValue|
		keyValue := p splitOnFirst: $=.
		self at: keyValue first trim asSymbol put: keyValue second ]
	
]

{ #category : #copying }
MicArgumentList >> withoutDefaultValue [
	"remove the defaultArg if no new value was assigned to it"
	^ self hasNonDefaultValue 
		ifTrue: [ ^ self ]
		ifFalse: [ self copy 
			removeKey: defaultArg ifAbsent: [ ]; 
			yourself ]
]
