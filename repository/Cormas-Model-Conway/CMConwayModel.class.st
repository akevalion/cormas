"
I'm a model of Conway's Game of Life: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent.

At each step in time, the following transitions occur:
- Any live cell with fewer than two live neighbours dies, as if caused by under-population.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by over-population.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
"
Class {
	#name : #CMConwayModel,
	#superclass : #CormasModel,
	#instVars : [
		'theCMConwayCells'
	],
	#category : 'Cormas-Model-Conway'
}

{ #category : #default }
CMConwayModel class >> defaultControl [
	^ #stepSynchronously:
]

{ #category : #default }
CMConwayModel class >> defaultFinalStep [
	^ 100
]

{ #category : #default }
CMConwayModel class >> defaultInit [
	^ #initRandomly
]

{ #category : #examples }
CMConwayModel class >> example1 [
	| aModel nbLines v es anim |
	aModel := self
		initialize;
		new.
	nbLines := 50.
	aModel initializeSpaceModel.
	aModel
		createGridX: nbLines
		Y: nbLines
		neighbourhood: 4
		closed: true.
	v := RTView new.
	aModel initSimulation.
	aModel runStep.
	v clean.
	es := (RTBox new
		color: [ :e | 
			e state == #dead
				ifTrue: [ Color white ]
				ifFalse: [ Color black ] ];
		size: 25) elementsOn: aModel theCMConwayCells.
	v addAll: es.
	RTGridLayout new
		gapSize: 0;
		lineItemsCount: aModel spaceModel column;
		on: v elements.
	v canvas camera focusOnCenterScaled.
	anim := RTActiveAnimation new.
	anim intervalInMilliseconds: 0.
	anim
		blockToExecute: [ aModel runStep.
			v elements do: #updateShape ].
	anim inView: v.
	v openWithToolbar  
]

{ #category : #examples }
CMConwayModel class >> example2 [
	| v nbLines choosenModel numberOfModels aModel models normalizer colors es groupsOfElements anim |
	v := RTView new.
	nbLines := 10.
	choosenModel := CMConwayModel.
	numberOfModels := 4.
	models := (1 to: numberOfModels)
		collect: [ :i | 
			aModel := choosenModel
				initialize;
				new.
			aModel initializeSpaceModel.
			aModel
				createGridX: nbLines
				Y: nbLines
				neighbourhood: 4
				closed: true.
			aModel initSimulation.
			aModel runStep.
			aModel ].
	normalizer := RTMultiLinearColor new colors: RTPalette c4.
	colors := (1 to: numberOfModels)
		collect: [ :i | normalizer level: (i / numberOfModels) asFloat ].
	groupsOfElements := models
		with: colors
		collect: [ :m :c | 
			es := (RTBox new
				color: [ :e | 
					e state == #dead
						ifTrue: [ Color white ]
						ifFalse: [ c ] ];
				size: 25) elementsOn: m theCMConwayCells.
			v addAll: es.
			RTGridLayout new
				gapSize: 0;
				lineItemsCount: m spaceModel column;
				on: es.
			es ].
	RTGridLayout on: groupsOfElements.
	v canvas camera focusOnCenterScaled.
	anim := RTActiveAnimation new.
	anim intervalInMilliseconds: 500.
	anim
		blockToExecute: [ models do: #runStep.
			v elements do: #updateShape ].
	anim inView: v.
	v openWithToolbar
]

{ #category : #examples }
CMConwayModel class >> example3 [
	| aModel nbLines v es anim |
	aModel := self
		initialize;
		new.
	nbLines := 100.
	aModel initializeSpaceModel.
	aModel
		createGridX: nbLines
		Y: nbLines
		neighbourhood: 4
		closed: true.
	v := RTView new.
	aModel initSimulation.
	aModel runStep.
	v clean.
	es := (RTBox new
		color: [ :e | 
			e state == #dead
				ifTrue: [ Color white ]
				ifFalse: [ Color black ] ];
		size: 25) elementsOn: aModel theCMConwayCells.
	v addAll: es.
	RTGridLayout new
		gapSize: 0;
		lineItemsCount: aModel spaceModel column;
		on: v elements.
	v canvas camera focusOnCenterScaled.
	anim := RTActiveAnimation new.
	anim intervalInMilliseconds: 0.
	anim
		blockToExecute: [ aModel runStep.
			v elements do: #updateShape ].
	anim inView: v.
	v openWithToolbar
]

{ #category : #examples }
CMConwayModel class >> example4 [
	| aModel |
	aModel := self initialize new initSimulation.
	(CMSimulationGrid initialize new
		on: aModel
		withCells: aModel theESE
		withSituatedEntities: aModel allTheSituatedEntities) runAndVisualize
]

{ #category : #examples }
CMConwayModel class >> example5 [
	| aModel |
	aModel := self initialize new.
	aModel activeInit: #initGlidersGun.
	aModel initSimulation.
	(CMSimulationGrid initialize new
		on: aModel
		withCells: aModel theESE
		withSituatedEntities: aModel allTheSituatedEntities) runAndVisualize
]

{ #category : #description }
CMConwayModel class >> howToRunIt [
	
	^'1. In the Model zone, double-click on the Cell entity that appears in the spatial entities list, you then access the definition window. 
1.1. Double-click on the initialize method. A text editor appears with the corresponding code (the state attribute of a Cell can take either the #dead or the #alive value). Close the text editor window.
1.2. Double-click on the newState method. A text editor appears with the code corresponding to the transition function of the game of life. Close both windows.

2. In the Model zone, at the bottom-right, in the Define the observation scrolling menu, choose the Space item. A window appears for the definition of viewpoints.
2.1. In the situated entities list, at the top-left, select Cell
2.2. In the observation methods list, below, select the pdv method.
2.3. If you click on the associated symbols in the list (at the top-right), you can visualize the colors corresponding to the different states of the Cell: #alive (white) #dead (black).
2.4. Close this window.

3. In the Visualization zone, open a spatial grid (1st icon). A new window opens. By default, it is a 10 * 10 spatial grid composed of 4-connexe squares with toroidal boundaries. 
3.1. Choose an 8-connexity: Topology -> Cell shape -> Square -> 8-connexe.
3.2. The Grid size item from the Topology menu perm opens a window allowing you to choose the number of lines and columns. For example, choose 50 * 50.
3.3. Initial state -> Execute method... -> initialize launches the execution of the initialization method (see step 1) for each cell of the grid.
3.4. If you right-click on the grid, you can choose for each entity of the model the observation method or viewpoint (cf. step 2). For the Cell choose the pdv viewpoint.

4. In the Simulation zone, click on the Initialize... button.
4.1. Select the init and evoluerSynchrone: methods.
4.2. Validate and close the window (Apply and close button).

5. In the Simulation zone, click on the Step button or enter the number of time steps in the Final time field and click Run. 

6. To launch the simulation from a particular initial situation (" glider gun " structure), load the gliderGun.ext file from the spatial grid menu: 
Initial state -> Attributes -> state -> Load map
Then repeat steps 4 and 5.'
]

{ #category : #probes }
CMConwayModel >> alive [
<probe>
	^ (self theCMConwayCells count: [ :c | c state = #alive ])
		/ self theCMConwayCells size
]

{ #category : #probes }
CMConwayModel >> dead [
<probe>
	^ (self theCMConwayCells count: [ :c | c state = #dead ])
		/ self theCMConwayCells size
]

{ #category : #init }
CMConwayModel >> initCustomMap [
	self loadEnvironmentFromFile: 'cormas.env'.
]

{ #category : #init }
CMConwayModel >> initGliders [
	self loadEnvironmentFromFile: 'gliders.env'
]

{ #category : #init }
CMConwayModel >> initGlidersGun [
	self loadEnvironmentFromFile: 'glidersGun.env'
]

{ #category : #init }
CMConwayModel >> initRandomly [
	
	self createGridX: 100 Y: 100 neighbourhood: 8 closed: true.
	self initCells: #initRandomly
]

{ #category : #init }
CMConwayModel >> initSmallGrid [
	self
		createGridX: 10
		Y: 10
		neighbourhood: 4
		closed: false.
	self initCells: #initRandomly
]

{ #category : #control }
CMConwayModel >> stepSynchronously: t [
	super stepSynchronously: t
]

{ #category : #accessing }
CMConwayModel >> theCMConwayCells [
	^ theCMConwayCells ifNil: [ theCMConwayCells := OrderedCollection new ]
]

{ #category : #accessing }
CMConwayModel >> theCMConwayCells: aCollection [
	theCMConwayCells := aCollection
]
