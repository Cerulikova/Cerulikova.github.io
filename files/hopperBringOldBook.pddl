;I've heard that the shopkeeper has an old book. Bring it to me and I'll make it worth your effort.
(define (problem bring_old_book)
	(:domain hopper_world)
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

		n0 - number
		n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 - number
		n31 n32 n33 n34 n35 n36 n37 n38 n39 n40 n41 n42 n43 n44 n45 n46 n47 n48 n49 n50 - number
		o_go - a_go
		o_collect - a_collect
		o_buy - a_buy
		o_steal - a_steal
		o_give - a_give
		o_player_give - a_player_give
		o_take - a_take
		o_attack_ch - a_attack_ch
		o_kill - a_kill
		o_talk - a_talk
		o_spy - a_spy
		o_bribe - a_bribe
		o_initimidate - a_intimidate
		o_read - a_read
		o_scare - a_scare
		o_run - a_run
		o_cure - a_cure
		o_attack_b - a_attack_b
		o_break - a_break
		o_fix_b - a_fix_b
		o_fix_i - a_fix_i
		o_refuse - a_refuse
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
		(has mage old_book)
		(has hopper gold_coin)	

		(not (and 
			(order o_go n0)
			(order o_go n1)
			(order o_steal n2)
			(order o_go n3)
			(order o_go n4)
			(order o_buy n5)
		))

		(not (and 
			(order o_go n0)
			(order o_go n1)
			(order o_steal n2)
			(order o_go n3)
			(order o_go n4)
			(order o_attack_ch n5)
			(order o_buy n6)
		))

		(not (and 
			(order o_go n0)
			(order o_go n1)
			(order o_steal n2)
			(order o_go n3)
			(order o_go n4)
			(order o_attack_b n5)
			(order o_buy n6)
		))
	))
)