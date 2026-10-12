;That wretched werewolf scratched my arm. Don't stand here! Do something!
(define (problem cure_hunter)
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
		forest - location
		sword - weapon
		med1 - medicine
		med2 - medicine
		gold - item
	)
	(:init

		(= (total-cost) 0)
		(= (collect-cost) 2)
		(= (buy-cost) 1)
		(= (steal-cost) 2)
		(= (give-cost) 1)
		(= (take-cost) 1)
		(= (attack_character-cost) 1)
		(= (kill-cost) 1)
		(= (talk-cost) 0)
		(= (spy-cost) 0)
		(= (bribe-cost) 0)
		(= (intimidate-cost) 0)
		(= (read-cost) 0)
		(= (scare_of-cost) 0)
		(= (cure-cost) 6)
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
		
	))

	(:metric minimize (total-cost))
)