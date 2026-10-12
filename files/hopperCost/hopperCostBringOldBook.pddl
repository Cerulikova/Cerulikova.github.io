;I've heard that the shopkeeper has an old book. Bring it to me and I'll make it worth your effort.

(define (problem bring_old_book)
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
		black_lily - item
		old_book - item
		gold_coin - item
		sword - weapon
	)
	(:init
		(= (total-cost) 0)
		(= (collect-cost) 1)
		(= (buy-cost) 2)
		(= (steal-cost) 3)
		(= (give-cost) 0)
		(= (take-cost) 1)
		(= (attack_character-cost) 1)
		(= (kill-cost) 1)
		(= (talk-cost) 0)
		(= (spy-cost) 0)
		(= (bribe-cost) 0)
		(= (intimidate-cost) 0)
		(= (read-cost) 0)
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
		(at black_lily meadow)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive mage)
		(has shopkeeper old_book)
		(has mage gold_coin)
		(has hopper sword)
		(blocks shopkeeper old_book)
		(blocks mage gold_coin)
		(price old_book black_lily)
		(price gold_coin old_book)
		(inhabited mill)
		(inhabited shop)
		(inhabited village)
		
	)
	(:goal (and
		(has mage old_book)
		(has hopper gold_coin)		
	))

	(:metric minimize (total-cost))
)