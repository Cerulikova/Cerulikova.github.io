;The hunter has put a note at the shop door. Find out what it is about.
(define (problem learn_about_note)
	(:domain hopper_quest_world)
	(:objects
		hopper - hero
		hunter - villager
		shopkeeper - villager
		mage - villager
		shop - building
		mill - building
		village - location
		meadow - location
		sword - weapon
		list - item
		note - information
	)
	(:init
		(path mill village)
		(path village mill)
		(path shop village)
		(path village shop)
		(path village meadow)
		(path meadow village)
		(at hopper mill)
		(at hunter village)
		(at shopkeeper shop)
		(at mage mill)
		(at list shop)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive mage)
		(has hopper sword)
		(knows hunter note)
		(contains_inf list note)
		(inhabited mill)
		(inhabited shop)
		(inhabited village)
		
	)
	(:goal (and
		(knows hopper note)
		
		;(talked hunter hopper)

		;(read_inf list hopper)
	))
)