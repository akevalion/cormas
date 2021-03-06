"
Stupides cell 
"
Class {
	#name : #CMStupidCell,
	#superclass : #CMSpatialEntityCell,
	#instVars : [
		'food'
	],
	#classVars : [
		'maxFoodProductionRate',
		'pallete'
	],
	#category : #'Cormas-Model-Stupid'
}

{ #category : #accessing }
CMStupidCell class >> maxFoodProductionRate [
	^ maxFoodProductionRate ifNil: [ maxFoodProductionRate := 0.01 ]
]

{ #category : #accessing }
CMStupidCell class >> maxFoodProductionRate: anObject [
	maxFoodProductionRate := anObject
]

{ #category : #accessing }
CMStupidCell class >> pallete [

	^ pallete ifNil: [ pallete := RTMultiLinearColor new
		colors: (RTColorPalette sequential colors: 9 scheme: 'YlGnBu') ].
]

{ #category : #accessing }
CMStupidCell >> food [
	^ food ifNil: [ food :=  0.1]
]

{ #category : #accessing }
CMStupidCell >> food: anObject [
	food := anObject
]

{ #category : #pov }
CMStupidCell >> pov [

	^ self class pallete
		rtValue: (self food)
]

{ #category : #pov }
CMStupidCell >> step [
	self updateFood.
]

{ #category : #pov }
CMStupidCell >> updateFood [
	self
		food: self food + (self food * (Cormas randomFloatFrom: 0 to: self class maxFoodProductionRate))
]
