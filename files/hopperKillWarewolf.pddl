;There is a warewolf at meadow near village. Kill it.
(define (problem kill_warewolf)
	(:domain hopper_world)
	(:objects
		hopper - hero
		hunter - villager
		shopkeeper - villager
		warewolf - monster
		sword - weapon
		axe - weapon
		gold_coin - item
		black_lily - item
		metal - material
		shop - building
		village - location
		meadow - location
		
		n0 - number
		n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 - number
		n31 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 n49 n50 - number
		o_go - a_go
		o_attack_ch - a_attack_ch
		o_ attack_b - a_attack_b
		o_kill - a_kill
		o_break - a_break
		o_collect - a_collect
		o_exchange - a_exchange
		o_give - a_give
		o_cure - a_cure
		o_fix_b - a_fix_b
		o_fix_i - a_fix_i
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
		(at black_lily meadow)
		(alive hopper)
		(alive hunter)
		(alive shopkeeper)
		(alive warewolf)
		(has hopper gold_coin)
		(has hunter sword)
		(has shopkeeper metal)
		(has shopkeeper axe)
		(broken sword)
		(blocks shopkeeper metal)
		(blocks shopkeeper axe)
		(price metal gold_coin)
		(price axe black_lily)
		(fixes metal sword)
		(can_fix hunter sword)
		
		(current n0)
		(next n0 n1)
		(next n1 n2)
		(next n2 n3)
		(next n3 n4)
		(next n4 n5)
		(next n5 n6)
		(next n6 n7)
		(next n7 n8)
		(next n8 n9)
		(next n9 n10)
		(next n10 n11)
		(next n11 n12)
		(next n12 n13)
		(next n13 n14)
		(next n14 n15)
		(next n15 n16)
		(next n16 n17)
		(next n17 n18)
		(next n18 n19)
		(next n19 n20)
		(next n20 n21)
		(next n21 n22)
		(next n22 n23)
		(next n23 n24)
		(next n25 n26)
		(next n26 n27)
		(next n27 n28)
		(next n28 n29)
		(next n29 n30)
		(next n30 n31)
		(next n31 n32)
		(next n32 n33)
		(next n33 n34)
		(next n34 n35)
		(next n35 n36)
		(next n36 n37)
		(next n37 n38)
		(next n38 n39)
		(next n39 n40)
		(next n40 n41)
		(next n41 n42)
		(next n42 n43)
		(next n43 n44)
		(next n44 n45)
		(next n45 n46)
		(next n46 n47)
		(next n47 n48)
		(next n48 n49)
		(next n49 n50)
		(next n50 n50)
	)
	(:goal (and
		(not (alive warewolf))
		
		(not (and 
			(order o_go n0)
			(order o_exchange n1)
			(order o_go n2)
			(order o_give n3)
			(order o_fix_i n4)
			(order o_give n5)
			(order o_go n6)
			(order o_attack_ch n7)
			(order o_kill n8)
		))
	))
)