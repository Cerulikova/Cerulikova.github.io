(define (domain hopper_world)
	(:requirements :strips :typing :derived-predicates :disjunctive-preconditions :existential-preconditions :equality)
	(:types
        entity location act number - object
		character item - entity
        hero villager monster - character
		medicine material weapon - item
		building - location
		
		a_go a_attack_ch a_attack_b a_kill a_break a_collect a_exchange a_give a_cure a_fix_b a_fix_i - act 
    )
	(:predicates
		(path ?a - location ?b - location)
		(at ?ch - entity ?l - location)
		(alive ?ch - character)
		(damaged ?w - object)
		(has ?ch - character ?i - item)
		(can_attack ?ch - character)
		(broken ?w - object)
		(blocks ?ch - character ?i - item)
		(blocked ?i - item)
		(price ?good - item ?cost - item)
		(fixes ?m - material ?w - object)
		(can_fix ?who - character ?what - item)
		
		(current ?i - number)
		(next ?i - number ?j - number)
		(order ?id - act ?i - number)
	)
	
	(:action go
		:parameters (?h - hero ?from - location ?to - location ?id - a_go ?i - number ?j - number)
		:precondition (and (path ?from ?to) (at ?h ?from) (alive ?h) (current ?i) (next ?i ?j))
		:effect (and (not (at ?h ?from)) (at ?h ?to) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action attack_character
		:parameters (?attacker - character ?who - character ?where - location ?id - a_attack_ch ?i - number ?j - number)
		:precondition (and (at ?attacker ?where) (at ?who ?where) (can_attack ?attacker) (alive ?attacker) (alive ?who) 
						(not (= ?attacker ?who)) (current ?i) (next ?i ?j))
		:effect (and (damaged ?who) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action attack_building
		:parameters (?attacker - character ?b - building ?id - a_attack_b ?i - number ?j - number)
		:precondition (and (at ?attacker ?b) (can_attack ?attacker) (alive ?attacker) (current ?i) (next ?i ?j))
		:effect (and (damaged ?b) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action kill
		:parameters (?killer - character ?killed - character ?where - location ?id - a_kill ?i - number ?j - number)
		:precondition (and (can_attack ?killer) (damaged ?killed) (alive ?killed) (alive ?killer) (at ?killer ?where) (at ?killed ?where)
						(not (= ?killer ?killed)) (current ?i) (next ?i ?j))
		:effect (and (not (alive ?killed)) (not (damaged ?killed)) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action break
		:parameters (?attacker - character ?b - building ?id - a_break ?i - number?j - number)
		:precondition (and (alive ?attacker) (at ?attacker ?b) (can_attack ?attacker) (damaged ?b) (current ?i)(next ?i ?j))
		:effect (and (broken ?b) (not (damaged ?b)) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action collect
		:parameters (?char - character ?it - item ?where - location ?id - a_collect ?i - number ?j - number)
		:precondition (and (at ?char ?where) (at ?it ?where) (not (blocked ?it)) (current ?i) (next ?i ?j))
		:effect (and (not (at ?it ?where)) (has ?char ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action exchange
		:parameters (?seller - character ?buyer - character ?i1 - item ?i2 - item ?l - location ?id - a_exchange ?i - number ?j - number)
		:precondition (and (alive ?seller) (alive ?buyer) (has ?seller ?i1) (has ?buyer ?i2) (at ?seller ?l) (at ?buyer ?l) 
							(blocks ?seller ?i1) (price ?i1 ?i2) (not (= ?seller ?buyer)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?seller ?i1)) (not (has ?buyer ?i2)) (has ?seller ?i2) (has ?buyer ?i1) (not (blocks ?seller ?i1)) 
					(order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action give
		:parameters (?char1 - character ?char2 - character ?it - item ?l - location ?id - a_give ?i - number ?j - number)
		:precondition (and (alive ?char1) (alive ?char2) (at ?char1 ?l) (at ?char2 ?l) (has ?char1 ?it) (not (blocks ?char1 ?it)) 
						(not (= ?char1 ?char2)) (current ?i) (next ?i ?j))
		:effect (and (not (has ?char1 ?it)) (has ?char2 ?it) (order ?id ?i) (not (current ?i)) (current ?j))
	)
	
	(:action cure
		:parameters (?char1 - character ?char2 - character ?potion - medicine ?l - location ?id - a_cure ?i - number ?j - number)
		:precondition (and (alive ?char1) (alive ?char2) (damaged ?char2) (has ?char1 ?potion) (at ?char1 ?l) (at ?char2 ?l) (current ?i)
							(next ?i ?j))
		:effect (and (not (damaged ?char2)) (not (has ?char1 ?potion)) (order ?id ?i) (not (current ?i)) (current ?j))
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
	
)