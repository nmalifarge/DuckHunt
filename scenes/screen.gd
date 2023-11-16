extends Node2D

#@export var bird_node : PackedScene
@onready var blue_bird : blue_bird = $blue_bird
@onready var bird : bird = $bird
#var bird_test

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_bird()

func spawn_bird():
	blue_bird.launch()
	bird.launch()

	#bird_test = bird_node.instantiate()
	#bird_test.exit.connect(_ready)
	#get_tree().current_scene.add_child(bird_test)



