Class {
	#name : #CormasModelTest,
	#superclass : #TestCase,
	#category : #'Cormas-Tests'
}

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testCentralCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 3
			Y: 3
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: model centralCell
		identicalTo: (model selectCellsOfColumn: 2) second
]

{ #category : #tests }
CormasModelTest >> testCreateGridXYNeighborHoodClosed [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: model allTheEntities size equals: 200.
	self assert: (model selectCellsOfColumn: 1) size equals: 20.
	self assert: (model selectCellsOfLine: 1) size equals: 10
]

{ #category : #tests }
CormasModelTest >> testDominance [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 100
			Y: 100
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: (model dominance: #state) < 1.0.

]

{ #category : #tests }
CormasModelTest >> testDominance1 [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 100
			Y: 100
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: (model dominance: #state) < 1.0
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testLowerLeftCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 3
			Y: 3
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: model lowerLeftCell
		identicalTo: (model selectCellsOfColumn: 1) third
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testLowerRightCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 3
			Y: 3
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: model lowerRightCell
		identicalTo: (model selectCellsOfColumn: 3) third
]

{ #category : #tests }
CormasModelTest >> testNbDistinctValuesOf [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: (model nbDistinctValuesOf: #state) equals: 1.
	(model selectCellsOfLine: 1) do: [ :cell | cell state: #dead ].
	self assert: (model nbDistinctValuesOf: #state) equals: 2.
	(model selectCellsOfLine: 2) first state: #theThirdState.
	self assert: (model nbDistinctValuesOf: #state) equals: 3
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickCell [
	| model cell |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	cell := model pickCell.
	self assert: cell isSpatialEntity.
	self assert: (cell x between: 1 and: 10).
	self assert: (cell y between: 1 and: 20)
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickCellConstrainedBy [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 9
			Y: 9
			neighbourhood: 4
			closed: true;
		initSimulation.
	model centralCell state: #alive.
	self
		assert: (model pickCellConstrainedBy: [ :cell | cell state = #alive ]) state
		equals: #alive.
	model centralCell state: #dead.
	self
		assert: (model pickCellConstrainedBy: [ :cell | cell state = #dead ]) state
		equals: #dead
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickCellWithoutAny [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation;
		createN: 50 randomlyLocatedAloneEntities: CMAgentLocationForTest.
	self
		assert:
			((model pickCellWithoutAny: CMAgentLocationForTest)
				occupantsAt: CMAgentLocationForTest) isEmpty
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickCellsN [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: ((model pickCellsN: 5) allSatisfy: [ :cell | cell isSpatialEntity ])
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickEntity [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: (model pickEntity: CMCellForTest) isSpatialEntity
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickEntityConstrainedBy [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert:
			(model pickEntity: CMCellForTest constrainedBy: [ :cell | cell x = 3 ])
				x
		equals: 3.
	self
		assert:
			(model pickEntity: CMCellForTest constrainedBy: [ :cell | cell x = 6 ])
				x
		equals: 6.
	self
		assert:
			(model pickEntity: CMCellForTest constrainedBy: [ :cell | cell x = 9 ])
				x
		equals: 9
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickNEntities [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert:
			((model pickN: 5 entities: CMCellForTest) allSatisfy: #isSpatialEntity)
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickNEntitiesConstrainedBy [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert:
			((model
				pickN: 5
				entities: CMCellForTest
				constrainedBy: [ :cell | cell x = 5 ])
				allSatisfy: [ :cell | cell x = 5 ])
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testPickUnoccupiedCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation;
		createN: 50 randomlyLocatedAloneEntities: CMAgentLocationForTest.
	self assert: model pickUnoccupiedCell theOccupants isEmpty
]

{ #category : #tests }
CormasModelTest >> testProbes [
	self
		assert: CormasModelForTest probes asSet
		equals: (Set with: #numAlives with: #numDeads)
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testSelectCellsInRectangle [
	| model cells |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	cells := model selectCellsInRectangle: (5 @ 5 corner: 7 @ 7).
	self assert: cells size equals: 9.
	cells
		do: [ :cell | 
			self assert: (cell x between: 5 and: 7).
			self assert: (cell y between: 5 and: 7) ]
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testSelectCellsInRectangleOriginCellCornerCell [
	| model cells |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 5
			Y: 9
			neighbourhood: 4
			closed: true;
		initSimulation.
	cells := model
		selectCellsInRectangleOriginCell: model upperLeftCell
		cornerCell: model centralCell.
	self assert: cells size equals: 15.
	cells
		do: [ :cell | 
			self assert: (cell x between: 1 and: 3).
			self assert: (cell y between: 1 and: 5) ]
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testSelectCellsOfColumn [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: model allTheEntities size equals: 200.
	1 to: 10 do: [ :column | 
		1 to: 20 do: [ :line | 
			self
				assert: ((model selectCellsOfColumn: column) at: line)
				identicalTo: ((model selectCellsOfLine: line) at: column) ] ]
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testSelectCellsOfLine [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation.
	self assert: model allTheEntities size equals: 200.
	1 to: 20 do: [ :line | 
		| cells |
		cells := model selectCellsOfLine: line.
		self assert: cells size equals: 10.
		cells do: [ :cell | self assert: cell y equals: line ] ]
]

{ #category : #tests }
CormasModelTest >> testShortestDistanceToCellsVerifying [
	| model |
	model := CormasModelForTest
		initialize;
		new.
	model initSimulation.
	(model allTheEntities: CMCellForTest)
		do: [ :cell | 
			self
				assert:
					(cell
						shortestDistanceToCellsVerifying: [ :c | c state = #dead | (c state = #alive) ])
				equals: 1 ]
]

{ #category : #tests }
CormasModelTest >> testSpacialClasses [
	self
		assert: CormasModelForTest spatialClasses
		equals: (Set with: CMCellForTest)
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testTheAgents [
	| model agents |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initAlive;
		initSimulation;
		initializeSpaceModel;
		createGridX: 10
			Y: 20
			neighbourhood: 4
			closed: true;
		initSimulation;
		createN: 50 randomlyLocatedAloneEntities: CMAgentLocationForTest.
	agents := model theAgents.
	self assert: agents size equals: 50.
	agents
		do:
			[ :agent | self assert: agent class identicalTo: CMAgentLocationForTest ]
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testUpperLeftCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 3
			Y: 3
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: model upperLeftCell
		identicalTo: (model selectCellsOfColumn: 1) first
]

{ #category : #'tests-accessing-entities' }
CormasModelTest >> testUpperRightCell [
	| model |
	model := (CormasModelForTest
		initialize;
		new)
		activeInit: #initRandom;
		initSimulation;
		initializeSpaceModel;
		createGridX: 3
			Y: 3
			neighbourhood: 4
			closed: true;
		initSimulation.
	self
		assert: model upperRightCell
		identicalTo: (model selectCellsOfColumn: 3) first
]
