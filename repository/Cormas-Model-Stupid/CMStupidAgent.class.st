"
A stupide agent
"
Class {
	#name : #CMStupidAgent,
	#superclass : #CMAgentLocation,
	#instVars : [
		'agsize'
	],
	#category : #'Cormas-Model-Stupid'
}

{ #category : #accessing }
CMStupidAgent >> agsize [
	^ agsize ifNil: [ agsize := 20 ]
]

{ #category : #accessing }
CMStupidAgent >> agsize: anObject [
	agsize := anObject
]

{ #category : #growth }
CMStupidAgent >> gowing [

	self agsize: (self agsize  + self patch food).
	self patch food: 0 .
]

{ #category : #running }
CMStupidAgent >> move [
	"move to an empty cell... if not don't move"

	self randomWalkConstrainedBy: [
			:c | c noOccupant 
		].
]

{ #category : #pov }
CMStupidAgent >> pov [

	^ Color blue
]

{ #category : #pov }
CMStupidAgent >> sizeOfPOV [
^ self agsize
]

{ #category : #scheduling }
CMStupidAgent >> step [

	self move.
	self gowing.
]
