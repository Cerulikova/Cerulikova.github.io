;There is a warewolf at meadow near village. Kill it.
(define (problem kill_warewolf)
	(:domain hopper_world)
	(:objects
		hopper - hero
		hunter - villager
		shopkeeper - villager
		warewolf - monster
		sword - weapon
		gold_coin - item
		metal - material
		shop - building
		village - location
		meadow - location
	)
	(:init
		(path shop village)
		(path village shop)
		(path village meadow)
		(path meadow village)
		(at hopper village)
		(at hunter village)
		(at shopkeeper shop)
		(at warewolf meadow)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive warewolf)
		(has hopper gold_coin)
		(has hunter sword)
		(has shopkeeper metal)
		(broken sword)
		(blocks shopkeeper metal)
		(price metal gold_coin)
		(fixes metal sword)
		(can_fix hunter sword)
	)
	(:goal (and
		(not (alive warewolf))
	))
)