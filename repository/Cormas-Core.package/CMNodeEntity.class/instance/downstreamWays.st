+ network
downstreamWays
	"returns a collection of all the ways from this Node towards the down stream direction (taking into account the orientation of the network). Each way is an ordered collection of nodes, starting with the receiver node. "
	
	| ways waysWithoutDuplicated |
	ways := self downstreamWays: (OrderedCollection with: OrderedCollection new).
	waysWithoutDuplicated := OrderedCollection new.
	ways do: [ : aWay | 
		(waysWithoutDuplicated anySatisfy: [ : coll | coll = aWay ])
			ifFalse: [ waysWithoutDuplicated add: aWay ] ].
	^ waysWithoutDuplicated