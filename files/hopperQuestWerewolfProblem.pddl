;There is a werewolf at meadow near the village. Deal with it, if you dare!
(define (problem werewolf_problem)
	(:domain hopper_quest_world)
	(:objects
		hopper - hero
		hunter - villager
		shopkeeper - villager
		mage - villager
		werewolf - monster
		shop - building
		mill - building
		village - location
		meadow - location
		forest - location
		sword - weapon
	)
	(:init
		(path mill village)
		(path village mill)
		(path shop village)
		(path village shop)
		(path village meadow)
		(path meadow village)
		(path meadow forest)
		(path forest meadow)
		(at hopper shop)
		(at hunter village)
		(at shopkeeper shop)
		(at mage mill)
		(at werewolf meadow)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive mage)
		(alive werewolf)
		(has hopper sword)
		(inhabited mill)
		(inhabited shop)
		(inhabited village)
		
	)
	(:goal (and
		;(dead werewolf) ;or
		(not (at werewolf meadow))
	))
)