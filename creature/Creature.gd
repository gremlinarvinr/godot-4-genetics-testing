extends Node2D
# Called when the node enters the scene tree for the first time.

var age: String
var black_locus: Array
var color_phenotype: String
var gender: String
var color: Color
var mother_name: String
var father_name: String
var paternal_father_name: String
var paternal_mother_name: String
var maternal_father_name: String
var maternal_mother_name: String

# var dragging = false

func _ready():
	add_to_group("creatures")
	get_tree().get_root().get_node("Main").connect("modulate_color", _on_modulate_color)
	
	
	var _creature_name: String
	if self.gender == "MALE":
		_creature_name = "[b][center]" + self.name + " - ♂️[/center][/b]" 
	else:
		_creature_name = "[b][center]" + self.name + " - ♀️[/center][/b]" 
		
	self.get_node("CharacterBody2D").get_node("CreatureName").set_text(_creature_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_character_body_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			GlobalVariables.selectedCreature = get_tree().get_root().get_node("Main").get_node(str(self.name))
			print(GlobalVariables.selectedCreature)
			SignalBus._select_creature.emit()
	#if event is InputEventMouseMotion and dragging:
		#self.position = event.position


func _on_modulate_color(node, color):
	node.get_node("CharacterBody2D").get_node("Sprite").modulate = color


func _on_main_age_up(target):
	target.get_node("CharacterBody2D").get_node("CreatureName").hide()
	target.age = "ADULT"
	target.get_node("CharacterBody2D").get_node("Sprite").scale = Vector2(1.2, 1.2)
	target.get_node("CharacterBody2D").get_node("CollisionPolygon2D2").scale = Vector2(1.2, 1.2)
	target.get_node("CharacterBody2D").get_node("CreatureName").position = Vector2(-79, -135)
