extends Node

var creature = preload("res://creature/Creature.tscn")

signal breed(father, mother)
signal modulate_color(baby, color)
signal age_up(target)

# needs to create two creatures, each with a phenotype and genotype
# needs to take user input to set these (first?)
# needs to output the possibilities 

# Called when the node enters the scene tree for the first time.
func _ready():	
	SignalBus.connect("_select_creature", _on_creature_select_creature)
	
	var father = creature.instantiate()
	father.name = "FatherCreature"
	father.age = "ADULT"
	father.gender = "MALE"
	GlobalVariables.currentFather = father
	
	
	father.position = Vector2(225, 200)
	father.get_node("CharacterBody2D").get_node("Sprite").scale = Vector2(1.2, 1.2)
	father.get_node("CharacterBody2D").get_node("CollisionPolygon2D2").scale = Vector2(1.2, 1.2)
	
	father.visible = true
	father.color_phenotype = "GRAY" # doesnt really matter to fix
	father.father_name = "Wild"
	father.mother_name = "Wild"
	father.paternal_father_name = "Wild"
	father.paternal_mother_name = "Wild"
	father.maternal_father_name = "Wild"
	father.maternal_mother_name = "Wild"
	
	father.black_locus = ["GRAY", "WHITE"]
	father.color = GlobalVariables.gray_modulation
	modulate_color.emit(father, father.color)
	# father.modulate = Color8(168, 34, 40, 225) # red
	father.get_node("CharacterBody2D").get_node("CreatureName").hide()
	add_child(father)
	GlobalVariables.creatureID + 1
	GlobalVariables.creatures_dict[father] = 1
	
	SignalBus._update_creature_box.emit("FATHER")
	father.owner = get_tree().edited_scene_root
	
	var mother = creature.instantiate() 
	mother.name = "MotherCreature"
	mother.age = "ADULT"
	mother.gender = "FEMALE"
	GlobalVariables.currentMother = mother
	
	mother.position = Vector2(1675, 200)
	mother.get_node("CharacterBody2D").get_node("Sprite").scale = Vector2(1.2, 1.2)
	mother.get_node("CharacterBody2D").get_node("CollisionPolygon2D2").scale = Vector2(1.2, 1.2)
	
	mother.visible = true
	mother.color_phenotype = "BLACK" # doesnt really matter to fix
	mother.father_name = "Wild"
	mother.mother_name = "Wild"
	mother.paternal_father_name = "Wild"
	mother.paternal_mother_name = "Wild"
	mother.maternal_father_name = "Wild"
	mother.maternal_mother_name = "Wild"
	
	mother.black_locus = ["BLACK", "WHITE"]
	mother.color = GlobalVariables.black_modulation
	modulate_color.emit(mother, mother.color)
	# mother.modulate =  Color8(34, 99, 168, 225) # blue
	mother.get_node("CharacterBody2D").get_node("CreatureName").hide()
	add_child(mother)
	GlobalVariables.creatureID + 1
	GlobalVariables.creatures_dict[mother] = 1
	
	SignalBus._update_creature_box.emit("MOTHER")
	mother.owner = get_tree().edited_scene_root


func _input(event): 
	if event.is_action_pressed("breed_creatures"):
		var _father
		var _mother
		
		# check if there is a valid mom and dad
		if GlobalVariables.currentFather != null && GlobalVariables.currentMother != null:
			_father = get_tree().get_root().get_node("Main").get_node(str(GlobalVariables.currentFather.name))
			_mother = get_tree().get_root().get_node("Main").get_node(str(GlobalVariables.currentMother.name))
			
			# NEW METHOD: DICT
			if GlobalVariables.creatures_dict.size() < 22:
				breed.emit(_father, _mother)
			else:
				print("Error: Too many babies!")
		else:
			print("Error: Cannot breed: you do not have a valid mother and father!")
	
	# delete selected creature
	if event.is_action_pressed("delete_creature"):
		if GlobalVariables.selectedCreature != null:
			
			if GlobalVariables.selectedCreature.name == GlobalVariables.currentFather.name:
				GlobalVariables.currentFather = null
			elif GlobalVariables.selectedCreature.name == GlobalVariables.currentMother.name:
				GlobalVariables.currentMother = null

			# NEW METHOD: DICT
			if GlobalVariables.creatures_dict.has(GlobalVariables.selectedCreature):
				GlobalVariables.selectedCreature.queue_free()
				GlobalVariables.creatures_dict.erase(GlobalVariables.selectedCreature)
				if GlobalVariables.creatures_dict.has(GlobalVariables.selectedCreature):
					print("Error: failed to delete selected creature.")
				else: 
					GlobalVariables.selectedCreature = null # fixes the weird bug ... 
					print("Successfuly deleted " + str(GlobalVariables.selectedCreature) + ".")
			else: 
				print(GlobalVariables.selectedCreature)
				print(GlobalVariables.creatures_dict)
				print("Error: cannot find creature's ID in the creatures dictionary!")
	
	if event.is_action_pressed("use_creature"):
		if GlobalVariables.selectedCreature != null:
			if GlobalVariables.currentFather == null && GlobalVariables.selectedCreature.gender == "MALE":
				GlobalVariables.currentFather = GlobalVariables.selectedCreature
				age_up.emit(GlobalVariables.selectedCreature)
				GlobalVariables.selectedCreature.position = Vector2(225, 200)
				SignalBus._update_creature_box.emit("FATHER")
				print(GlobalVariables.currentFather)
			elif GlobalVariables.currentMother == null && GlobalVariables.selectedCreature.gender == "FEMALE":
				GlobalVariables.currentMother = GlobalVariables.selectedCreature
				age_up.emit(GlobalVariables.selectedCreature)
				GlobalVariables.selectedCreature.position = Vector2(1675, 200)
				SignalBus._update_creature_box.emit("MOTHER")
				print(GlobalVariables.currentMother)
			else: 
				print("Error: You must clear a spot for the creature to age up")
				
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_breeding_create_baby(black_locus, color_phenotype, color, gender):
	var baby = creature.instantiate()
	GlobalVariables.creatureID += 1
	baby.name = str("ChildCreature-", GlobalVariables.creatureID)
	baby.gender = gender
	baby.age = "BABY"
	
	baby.get_node("CharacterBody2D").get_node("Sprite").scale = Vector2(.5, .5)
	baby.get_node("CharacterBody2D").get_node("CollisionPolygon2D2").scale = Vector2(.5, .5)
	
	baby.father_name = GlobalVariables.currentFather.name
	baby.mother_name = GlobalVariables.currentMother.name
	baby.paternal_father_name = GlobalVariables.currentFather.father_name
	baby.paternal_mother_name = GlobalVariables.currentFather.mother_name
	baby.maternal_father_name = GlobalVariables.currentMother.father_name
	baby.maternal_mother_name = GlobalVariables.currentMother.mother_name
	
	# genotype and phenotype ... 
	baby.color_phenotype = color_phenotype
	modulate_color.emit(baby, color)
	baby.black_locus = black_locus
	baby.visible = true
	
	# spawn them in :3
	var baby_spawn_location = get_node("BabyPath/BabySpawnLocation")
	baby_spawn_location.progress = randi()
	baby.position = baby_spawn_location.position 
	baby.get_node("CharacterBody2D").get_node("CreatureName").position = Vector2(-79, -85)

	# DICT METHOD
	GlobalVariables.creatures_dict[baby] = 1
	
	add_child(baby, true)
	

func _on_creature_select_creature():
	print("CREATURE: " + str(GlobalVariables.selectedCreature.name))
	print("-- Age: " + str(GlobalVariables.selectedCreature.age))
	print("-- Gender: " + str(GlobalVariables.selectedCreature.gender))
	print("-- Black locus: " + str(GlobalVariables.selectedCreature.black_locus))
	print("-- Phenotype: " + str(GlobalVariables.selectedCreature.color_phenotype))
	print("-- Color: " + str(GlobalVariables.selectedCreature.color))
