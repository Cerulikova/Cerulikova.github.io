(define (domain hopper_world)
	(:requirements :strips :typing :derived-predicates :disjunctive-preconditions :existential-preconditions :equality)
	(:types
        	entity location information act number - object
		character item - entity
        	hero villager monster - character
		medicine material weapon - item
		building - location
		
		a_go a_collect a_buy a_steal a_give a_player_give a_take a_attack_ch a_kill a_talk a_spy a_bribe a_intimidate a_read a_scare a_run a_cure a_attack_b a_break a_fix_b a_fix_i a_refuse - act 
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
		(contains_inf ?i - item ?inf - information)
		(secret ?inf - information)
		(inf_cost ?inf - information ?it - item)
		(inhabited ?l - location)
		(scared ?ch - character)
		(bought ?i - item ?from - character)
		(stolen ?i - item ?from - character)
		(knows ?who - character ?inf - information)
		
		(current ?i - number)
		(next ?i - number ?j - number)
		(order ?id - act ?i - number)

		(refused ?h - hero ?ch - character)
	)
	
	(:action go
		:parameters (?h - hero ?from - location ?to - location ?id - a_go ?i - number ?j - number)
		:precondition (and (path ?from ?to) (at ?h ?from) (alive ?h) (current ?i) (next ?i ?j))
		:effect (and (not (at ?h ?from)) (at ?h ?to) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action collect
		:parameters (?char - character ?it - item ?where - location ?id - a_collect ?i - number ?j - number)
		:precondition (and (at ?char ?where) (at ?it ?where) (not (blocked ?it)) (current ?i) (next ?i ?j))
		:effect (and (not (at ?it ?where)) (has ?char ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action buy
		:parameters (?seller - character ?buyer - character ?i1 - item ?i2 - item ?l - location ?id - a_buy ?i - number ?j - number)
		:precondition (and (alive ?seller) (alive ?buyer) (has ?seller ?i1) (has ?buyer ?i2) (at ?seller ?l) (at ?buyer ?l) 
							(blocks ?seller ?i1) (price ?i1 ?i2) (not (= ?seller ?buyer)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?seller ?i1)) (not (has ?buyer ?i2)) (has ?seller ?i2) (has ?buyer ?i1) (not (blocks ?seller ?i1)) 
					(bought ?i1 ?seller) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action steal
		:parameters (?h - hero ?ch - character ?it - item ?l - location ?id - a_steal ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?ch) (has ?ch ?it) (at ?ch ?l) (at ?h ?l) (not (= ?h ?ch)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?ch ?it)) (has ?h ?it) (stolen ?it ?ch) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action give
		:parameters (?v - villager ?char - character ?it - item ?l - location ?id - a_give ?i - number ?j - number)
		:precondition (and (alive ?v) (alive ?char) (at ?v ?l) (at ?char ?l) (has ?v ?it) (not (blocks ?v ?it)) 
						(not (= ?v ?char)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?v ?it)) (has ?char ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action player_give
		:parameters (?h - hero ?v - villager ?it - item ?l - location ?id - a_player_give ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?v) (at ?h ?l) (at ?v ?l) (has ?h ?it) (not (blocks ?h ?it))
				(not (bought ?it ?v)) (not (stolen ?it ?v)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?h ?it)) (has ?v ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action take
		:parameters (?ch1 - character ?ch2 - character ?it - item ?l - location ?id - a_take ?i - number ?j - number)
		:precondition (and (alive ?ch1) (dead ?ch2) (has ?ch2 ?it) (at ?ch1 ?l) (at ?ch2 ?l) (current ?i) (next ?i ?j))
		:effect (and (not (has ?ch2 ?it)) (has ?ch1 ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action attack_character
		:parameters (?attacker - character ?who - character ?where - location ?id - a_attack_ch ?i - number ?j - number)
		:precondition (and (at ?attacker ?where) (at ?who ?where) (can_attack ?attacker) (alive ?attacker) (alive ?who) 
						(not (= ?attacker ?who)) (current ?i) (next ?i ?j))
		:effect (and (damaged ?who) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action kill
		:parameters (?killer - character ?killed - character ?where - location ?id - a_kill ?i - number ?j - number)
		:precondition (and (can_attack ?killer) (damaged ?killed) (alive ?killed) (alive ?killer) (at ?killer ?where) (at ?killed ?where)
						(not (= ?killer ?killed)) (current ?i) (next ?i ?j))
		:effect (and (not (alive ?killed)) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action talk
		:parameters (?ch1 - character ?ch2 - character ?inf - information ?l - location ?id - a_talk ?i - number ?j - number)
		:precondition (and (alive ?ch1) (alive ?ch2) (at ?ch1 ?l) (at ?ch2 ?l) (knows ?ch1 ?inf) (not (secret ?inf))
				(not (= ?ch1 ?ch2)) (current ?i) (next ?i ?j))
		:effect (and (knows ?ch2 ?inf) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action spy
		:parameters (?h - hero ?ch - character ?inf - information ?l - location ?id - a_spy ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (not (= ?h ?ch)) (current ?i) (next ?i ?j))
		:effect (and (knows ?h ?inf) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action bribe
		:parameters (?h - hero ?ch - character ?inf - information ?l - location ?it - item ?id - a_bribe ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (secret ?inf) 
					(inf_cost ?inf ?it) (has ?h ?it) (not (= ?h ?ch)) (current ?i) (next ?i ?j))
		:effect (and (knows ?h ?inf) (not(has ?h ?it)) (has ?ch ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action intimidate
		:parameters (?h - hero ?ch - character ?inf - information ?l - location ?id - a_intimidate ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?ch) (at ?h ?l) (at ?ch ?l) (knows ?ch ?inf) (secret ?inf) (not (= ?h ?ch)) (current ?i) (next ?i ?j))
		:effect (and (knows ?h ?inf) (scared ?ch) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action read
		:parameters (?h - hero ?it - item ?inf - information ?id - a_read ?i - number ?j - number)
		:precondition (and (alive ?h) (has ?h ?it) (contains_inf ?it ?inf) (current ?i) (next ?i ?j))
		:effect (and (knows ?h ?inf) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action scare_of
		:parameters (?h - hero ?m - monster ?l - location ?id - a_scare ?i - number ?j - number)
		:precondition (and (alive ?h) (alive ?m) (damaged ?m) (at ?h ?l) (at ?m ?l) (current ?i) (next ?i ?j))
		:effect (and (scared ?m) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action run_away
		:parameters (?m - monster ?l1 - location ?l2 - location ?id - a_run ?i - number ?j - number)
		:precondition (and (alive ?m) (at ?m ?l1) (path ?l1 ?l2) (not (inhabited ?l2)) (scared ?m) (current ?i) (next ?i ?j))
		:effect (and (not (at ?m ?l1)) (at ?m ?l2) (not (scared ?m)) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action cure
		:parameters (?char1 - character ?char2 - character ?potion - medicine ?l - location ?id - a_cure ?i - number ?j - number)
		:precondition (and (alive ?char1) (alive ?char2) (damaged ?char2) (has ?char1 ?potion) (at ?char1 ?l) (at ?char2 ?l) (current ?i)
							(next ?i ?j))
		:effect (and (not (damaged ?char2)) (not (has ?char1 ?potion)) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action attack_building
		:parameters (?attacker - character ?b - building ?id - a_attack_b ?i - number ?j - number)
		:precondition (and (at ?attacker ?b) (can_attack ?attacker) (alive ?attacker) (current ?i) (next ?i ?j))
		:effect (and (damaged ?b) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action break
		:parameters (?attacker - character ?b - building ?id - a_break ?i - number?j - number)
		:precondition (and (alive ?attacker) (at ?attacker ?b) (can_attack ?attacker) (damaged ?b) (current ?i)(next ?i ?j))
		:effect (and (broken ?b) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action fix_building
		:parameters (?char - character ?b - building ?m - material ?id - a_fix_b ?i - number ?j - number)
		:precondition (and (alive ?char) (at ?char ?b) (has ?char ?m) (or (damaged ?b) (broken ?b)) (fixes ?m ?b) (current ?i)(next ?i ?j))
		:effect (and (not (has ?char ?m)) (not (damaged ?b)) (not (broken ?b)) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action fix_item
		:parameters (?char - character ?it - item ?m - material ?id - a_fix_i ?i - number ?j - number)
		:precondition (and (alive ?char) (has ?char ?m) (has ?char ?it) (or (damaged ?it) (broken ?it)) (fixes ?m ?it) (can_fix ?char ?it)
							(current ?i) (next ?i ?j))
		:effect (and (not (has ?char ?m)) (not (damaged ?it)) (not (broken ?it)) (order ?id ?i) (not (current ?i)) (current ?j))
	)

	(:action refuse
		:parameters (?h - hero ?v - villager ?l - location ?id - a_refuse ?i - number ?j - number)
		:precondition (and (at ?h ?l) (at ?v ?l) (current ?i) (next ?i ?j))
		:effect (and (refused ?h ?v) (order ?id ?i) (not (current ?i)) (current ?j))
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