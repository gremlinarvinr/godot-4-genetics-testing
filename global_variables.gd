extends Node

var creatureID: int = 0

# god i really need to learn what variant these guys are
var selectedCreature: Node
var currentMother
var currentFather

# NEW METHOD: DICTIONARY (holds all the creature info, may need to rework it to just be ID that can later be retrieved to select the node? idk what performance impact would be like in a bigger project)
var creatures_dict = {}

# COLORS - do a dictionary ? array ? something ? to make it easier ?
var black_modulation = Color8(40, 40, 40, 255)
var gray_modulation = Color8(105, 105, 105, 255)
var white_modulation = Color8(250, 250, 250, 255)

# GENETICS
# Black Locus
var black_locus_dict = {
	1: "BLACK",
	2: "GRAY",
	3: "WHITE"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
