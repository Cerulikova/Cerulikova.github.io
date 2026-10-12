;There is a werewolf at meadow near the village. Deal with it, if you dare!
(define (problem werewolf_problem)
	(:domain hopper_cost_world)
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
		(= (total-cost) 0)
		(= (collect-cost) 0)
		(= (buy-cost) 0)
		(= (steal-cost) 0)
		(= (give-cost) 0)
		(= (take-cost) 0)
		(= (attack_character-cost) 3)
		(= (kill-cost) 2)
		(= (talk-cost) 0)
		(= (spy-cost) 0)
		(= (bribe-cost) 0)
		(= (intimidate-cost) 0)
		(= (read-cost) 0)
		(= (scare_of-cost) 1)
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
	(:goal (or
		(dead werewolf)
		(not (at werewolf meadow))
	))
	(:metric minimize (total-cost))
)