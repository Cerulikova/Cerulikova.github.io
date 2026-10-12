;The hunter has put a note at the shop door. Find out what it is about.
(define (problem learn_about_note)
	(:domain hopper_cost_world)
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
		(= (total-cost) 0)
		(= (collect-cost) 1)
		(= (buy-cost) 0)
		(= (steal-cost) 0)
		(= (give-cost) 0)
		(= (take-cost) 0)
		(= (attack_character-cost) 0)
		(= (kill-cost) 0)
		(= (talk-cost) 1)
		(= (spy-cost) 2)
		(= (bribe-cost) 0)
		(= (intimidate-cost) 0)
		(= (read-cost) 1)
		(= (scare_of-cost) 0)
		(= (cure-cost) 0)
		(= (attack_building-cost) 0)
		(= (break-cost) 0)
		(= (fix_building-cost) 0)
		(= (fix_item-cost) 0)

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
		
		;(talked hunter hopper note)

		;(read_inf list hopper note)
	))
	(:metric minimize (total-cost))
)