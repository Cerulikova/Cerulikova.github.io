;I've heard that the shopkeeper has an old book. Bring it to me and I'll make it worth your effort.
(define (problem bring_old_book)
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
		black_lily - item
		old_book - item
		gold_coin - item
		sword - weapon
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

		;(bought old_book)

		;(stolen old_book)

		;(given old_book)

		;(dead shopkeeper)
		
		
	))
)