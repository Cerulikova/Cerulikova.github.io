(define (domain hopper_world)
	(:requirements :strips :typing :derived-predicates :disjunctive-preconditions :existential-preconditions :equality)
	(:types
        entity location - object
		character item - entity
        hero villager monster - character
		medicine material weapon - item
		building - location
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
	)
	
	(:action go
		:parameters (?h - hero ?from - location ?to - location)
		:precondition (and (path ?from ?to) (at ?h ?from) (alive ?h))
		:effect (and (not (at ?h ?from)) (at ?h ?to))
	)
	
	(:action attack_character
		:parameters (?attacker - character ?who - character ?where - location)
		:precondition (and (at ?attacker ?where) (at ?who ?where) (can_attack ?attacker) (alive ?attacker) (alive ?who) 
						(not (= ?attacker ?who)))
		:effect (and (damaged ?who))
	)
	
	(:action attack_building
		:parameters (?attacker - character ?b - building)
		:precondition (and (at ?attacker ?b) (can_attack ?attacker) (alive ?attacker))
		:effect (and (damaged ?b))
	)
	
	(:action kill
		:parameters (?killer - character ?killed - character ?where - location)
		:precondition (and (can_attack ?killer) (damaged ?killed) (alive ?killed) (alive ?killer) (at ?killer ?where) (at ?killed ?where)
						(not (= ?killer ?killed)))
		:effect (and (not (alive ?killed)) (not (damaged ?killed)))
	)
	
	(:action break
		:parameters (?attacker - character ?b - building)
		:precondition (and (alive ?attacker) (at ?attacker ?b) (can_attack ?attacker) (damaged ?b))
		:effect (and (broken ?b) (not (damaged ?b)))
	)
	
	(:action collect
		:parameters (?char - character ?i - item ?where - location)
		:precondition (and (at ?char ?where) (at ?i ?where) (not (blocked ?i)))
		:effect (and (not (at ?i ?where)) (has ?char ?i))
	)
	
	(:action exchange
		:parameters (?seller - character ?buyer - character ?i1 - item ?i2 - item ?l - location)
		:precondition (and (alive ?seller) (alive ?buyer) (has ?seller ?i1) (has ?buyer ?i2) (at ?seller ?l) (at ?buyer ?l) 
							(blocks ?seller ?i1) (price ?i1 ?i2) (not (= ?seller ?buyer)))
		:effect (and (not (has ?seller ?i1)) (not (has ?buyer ?i2)) (has ?seller ?i2) (has ?buyer ?i1) (not (blocks ?seller ?i1)))
	)
	
	(:action give
		:parameters (?char1 - character ?char2 - character ?i - item ?l - location)
		:precondition (and (alive ?char1) (alive ?char2) (at ?char1 ?l) (at ?char2 ?l) (has ?char1 ?i) (not (blocks ?char1 ?i)) 
						(not (= ?char1 ?char2)))
		:effect (and (not (has ?char1 ?i)) (has ?char2 ?i))
	)
	
	(:action cure
		:parameters (?char1 - character ?char2 - character ?potion - medicine ?l - location)
		:precondition (and (alive ?char1) (alive ?char2) (damaged ?char2) (has ?char1 ?potion) (at ?char1 ?l) (at ?char2 ?l))
		:effect (and (not (damaged ?char2)) (not (has ?char1 ?potion)))
	)
	
	(:action fix_building
		:parameters (?char - character ?b - building ?m - material)
		:precondition (and (alive ?char) (at ?char ?b) (has ?char ?m) (or (damaged ?b) (broken ?b)) (fixes ?m ?b))
		:effect (and (not (has ?char ?m)) (not (damaged ?b)) (not (broken ?b)))
	)
	
	(:action fix_item
		:parameters (?char - character ?i - item ?m - material)
		:precondition (and (alive ?char) (has ?char ?m) (has ?char ?i) (or (damaged ?i) (broken ?i)) (fixes ?m ?i) (can_fix ?char ?i))
		:effect (and (not (has ?char ?m)) (not (damaged ?i)) (not (broken ?i)))
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