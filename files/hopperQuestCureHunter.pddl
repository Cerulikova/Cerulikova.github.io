;That wretched werewolf scratched my arm. Don't stand here! Do something!
(define (problem cure_hunter)
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
		forest - location
		sword - weapon
		med1 - medicine
		med2 - medicine
		gold - item
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
		(at hopper village)
		(at hunter village)
		(at shopkeeper shop)
		(at mage mill)
		(at med1 forest)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive mage)
		(damaged hunter)
		(has hopper sword)
		(has mage med2)
		(has hunter gold)
		(blocks mage med2)
		(price med2 gold)
		(inhabited mill)
		(inhabited shop)
		(inhabited village)
		
	)
	(:goal (and
		(not (damaged hunter))
		
		;(used med1)

		;(used med2)
		;(bought med2)

		;(used med2)
		;(dead mage)
	))
)