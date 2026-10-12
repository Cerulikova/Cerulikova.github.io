(define (domain hopper_cost_world)
	(:requirements :strips :typing :derived-predicates :disjunctive-preconditions :existential-preconditions :equality :action-costs)
	(:types
		entity location information - object
		character item - entity
		hero villager monster - character
		medicine material weapon - item
		building - location
	)

	(:functions
		;go, player_give, run_away and refuseare always for free 
		(total-cost) - number
		(collect-cost) - number
		(buy-cost) - number
		(steal-cost) - number
		(give-cost) - number
		(take-cost) - number
		(attack_character-cost) - number
		(kill-cost) - number
		(talk-cost) - number
		(spy-cost) - number
		(bribe-cost) - number
		(intimidate-cost) - number
		(read-cost) - number
		(scare_of-cost) - number
		(cure-cost) - number
		(attack_building-cost) - number
		(break-cost) - number
		(fix_building-cost) - number
		(fix_item-cost) - number
	)

	(:predicates
		(path ?a - location ?b - location)
		(at ?ch - entity ?l - location)
		(alive ?ch - character)
		(dead ?ch - character)
		(damaged ?w - object)
		(has ?ch - character ?i - item)
		(can_attack ?ch - character)
		(broken ?w - object)
		(blocks ?ch - character ?i - item)
		(blocked ?i - item)
		(price ?good - item ?cost - item)
		(fixes ?m - material ?w - object)
		(can_fix ?who - character ?what - item)
		(knows ?who - character ?inf - information)
		(contains_inf ?i - item ?inf - information)
		(secret ?inf - information)
		(inf_cost ?inf - information ?it - item)
		(inhabited ?l - location)

		(collected ?i - item)
		(bought ?i - item ?from - character)
		(stolen ?i - item ?from - character)
		(taken ?i - item ?from - character)
		(given ?i - item ?by - character)
		(talked ?ch1 - character ?ch2 - character ?about - information)
		(spied ?who - character ?target - character ?inf - information)
		(bribed ?ch - character)
		(scared ?ch - character)
		(read_inf ?i - item ?ch - character ?inf - information)
		(used ?i - item)
		
		(refused ?h - hero ?ch - character)
		
	)

	(:action go
		:parameters (?h - hero ?from - location ?to - location)
		:precondition (and (path ?from ?to) (at ?h ?from) (alive ?h))
		:effect (and (not (at ?h ?from)) (at ?h ?to) )
	)

	(:action collect
		:parameters (?char - character ?it - item ?where - location)
		:precondition (and (at ?char ?where) (at ?it ?where) (not (blocked ?it)))
		:effect (and (not (at ?it ?where)) (has ?char ?it) (collected ?it)
			(increase (total-cost) (collect-cost)))
	)

	(:action buy
		:parameters (?seller - character ?buyer - character ?i1 - item ?i2 - item ?l - location)
		:precondition (and (alive ?seller) (alive ?buyer) (has ?seller ?i1) (has ?buyer ?i2) (at ?seller ?l)
						(at ?buyer ?l) (blocks ?seller ?i1) (price ?i1 ?i2) (not (= ?seller ?buyer)))
		:effect (and (not (has ?seller ?i1)) (not (has ?buyer ?i2)) (has ?seller ?i2) (has ?buyer ?i1)
					(not (blocks ?seller ?i1)) (bought ?i1 ?seller)
			(increase (total-cost) (buy-cost)))
	)

	(:action steal
		:parameters (?h - hero ?ch - character ?it - item ?l - location)
		:precondition (and (alive ?h) (alive ?ch) (has ?ch ?it) (at ?ch ?l) (at ?h ?l) (not (= ?h ?ch)))
		:effect (and (not (has ?ch ?it)) (has ?h ?it) (stolen ?it ?ch)
			(increase (total-cost) (steal-cost)))
	)

	(:action give
		:parameters (?v - villager ?char - character ?it - item ?l - location)
		:precondition (and (alive ?v) (alive ?char) (at ?v ?l) (at ?char ?l) (has ?v ?it)
					(not (blocks ?v ?it)) (not (= ?v ?char)))
		:effect (and (not (has ?v ?it)) (has ?char ?it) (given ?it ?v)
			(increase (total-cost) (give-cost)))
	)

	(:action player_give
		:parameters (?h - hero ?v - villager ?it - item ?l - location)
		:precondition (and (alive ?h) (alive ?v) (at ?h ?l) (at ?v ?l) (has ?h ?it)
					(not (blocks ?h ?it)) (not (bought ?it ?v)) (not (stolen ?it ?v)))
		:effect (and (not (has ?h ?it)) (has ?v ?it))
	)

	(:action take
		:parameters (?ch1 - character ?ch2 - character ?it - item ?l - location)
		:precondition (and (alive ?ch1) (dead ?ch2) (has ?ch2 ?it) (at ?ch1 ?l) (at ?ch2 ?l))
		:effect (and (not (has ?ch2 ?it)) (has ?ch1 ?it) (taken ?it ?ch2)
			(increase (total-cost) (take-cost)))
	)

	(:action attack_character
		:parameters (?attacker - character ?who - character ?where - location)
		:precondition (and (at ?attacker ?where) (at ?who ?where) (can_attack ?attacker) (alive ?attacker)
						(alive ?who) (not (= ?attacker ?who)))
		:effect (and (damaged ?who)
			(increase (total-cost) (attack_character-cost)))
	)

	(:action kill
		:parameters (?killer - character ?killed - character ?where - location)
		:precondition (and (can_attack ?killer) (damaged ?killed) (alive ?killed) (alive ?killer) (at ?killer ?where)
						(at ?killed ?where) (not (= ?killer ?killed)))
		:effect (and (not (alive ?killed))
			(increase (total-cost) (kill-cost)))
	)

	(:action talk
		:parameters (?ch1 - character ?ch2 - character ?inf - information ?l - location)
		:precondition (and (alive ?ch1) (alive ?ch2) (at ?ch1 ?l) (at ?ch2 ?l) (knows ?ch1 ?inf)
				 (not (secret ?inf)) (not (= ?ch1 ?ch2)))
		:effect (and (knows ?ch2 ?inf) (talked ?ch1 ?ch2 ?inf)
			(increase (total-cost) (talk-cost)))
	)

	(:action spy
		:parameters (?h - hero ?ch - character ?inf - information ?l - location)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (not (= ?h ?ch)))
		:effect (and (knows ?h ?inf) (spied ?h ?ch ?inf)
			(increase (total-cost) (spy-cost)))
	)

	(:action bribe
		:parameters (?h - hero ?ch - character ?inf - information ?l - location ?it - item)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (secret ?inf) 
					(inf_cost ?inf ?it) (has ?h ?it) (not (= ?h ?ch)))
		:effect (and (knows ?h ?inf) (not(has ?h ?it)) (has ?ch ?it) (bribed ?ch)
			(increase (total-cost) (bribe-cost)))
	)

	(:action intimidate
		:parameters (?h - hero ?ch - character ?inf - information ?l - location)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (secret ?inf)
				(not (= ?h ?ch)))
		:effect (and (knows ?h ?inf) (scared ?ch)
			(increase (total-cost) (intimidate-cost)))
	)

	(:action read
		:parameters (?h - hero ?it - item ?inf - information)
		:precondition (and (alive ?h) (has ?h ?it) (contains_inf ?it ?inf))
		:effect (and (knows ?h ?inf) (read_inf ?it ?h ?inf)
			(increase (total-cost) (read-cost)))
	)

	(:action scare_of
		:parameters (?h - hero ?m - monster ?l - location)
		:precondition (and (alive ?h) (alive ?m) (damaged ?m) (at ?h ?l) (at ?m ?l))
		:effect (and (scared ?m)
			(increase (total-cost) (scare_of-cost)))
	)

	(:action run_away
		:parameters (?m - monster ?l1 - location ?l2 - location)
		:precondition (and (alive ?m) (at ?m ?l1) (path ?l1 ?l2) (not (inhabited ?l2)) (scared ?m))
		:effect (and (not (at ?m ?l1)) (at ?m ?l2) (not (scared ?m)))
	)

	(:action cure
		:parameters (?char1 - character ?char2 - character ?potion - medicine ?l - location)
		:precondition (and (alive ?char1) (alive ?char2) (damaged ?char2) (has ?char1 ?potion)
					(at ?char1 ?l) (at ?char2 ?l))
		:effect (and (not (damaged ?char2)) (not (has ?char1 ?potion)) (used ?potion)
			(increase (total-cost) (cure-cost)))
	)

	(:action attack_building
		:parameters (?attacker - character ?b - building)
		:precondition (and (at ?attacker ?b) (can_attack ?attacker) (alive ?attacker))
		:effect (and (damaged ?b)
			(increase (total-cost) (attack_building-cost)))
	)

	(:action break
		:parameters (?attacker - character ?b - building)
		:precondition (and (alive ?attacker) (at ?attacker ?b) (can_attack ?attacker) (damaged ?b))
		:effect (and (broken ?b)
			(increase (total-cost) (break-cost)))
	)

	(:action fix_building
		:parameters (?char - character ?b - building ?m - material)
		:precondition (and (alive ?char) (at ?char ?b) (has ?char ?m) (or (damaged ?b) (broken ?b))
				 (fixes ?m ?b))
		:effect (and (not (has ?char ?m)) (not (damaged ?b)) (not (broken ?b)) (used ?m)
			(increase (total-cost) (fix_building-cost)))
	)
	
	(:action fix_item
		:parameters (?char - character ?it - item ?m - material)
		:precondition (and (alive ?char) (has ?char ?m) (has ?char ?it) (or (damaged ?it) (broken ?it))
					 (fixes ?m ?it) (can_fix ?char ?it))
		:effect (and (not (has ?char ?m)) (not (damaged ?it)) (not (broken ?it)) (used ?m)
			(increase (total-cost) (fix_item-cost)))
	)

	(:action refuse
		:parameters (?h - hero ?v - villager ?l - location)
		:precondition (and (at ?h ?l) (at ?v ?l))
		:effect (and (refused ?h ?v))
	)

	(:derived (blocked ?i - item)
		(exists (?ch - character)
			(and
				(blocks ?ch ?i)
				(alive ?ch)
			)
		)
	)
	
	(:derived (can_attack ?h - hero)
		(exists (?w - weapon)
			(and (has ?h ?w)
				(not (broken ?w)))
		)
	)
	
	(:derived (can_attack ?m - monster)
		(exists (?m)
			(alive ?m)
		)
	)

	(:derived (dead ?ch - character)
		(not (alive ?ch))
	)
)