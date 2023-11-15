extends Node2D

@export var bird_node : PackedScene
var bird

# Called when the node enters the scene tree for the first time.
func _ready():
	bird = bird_node.instantiate()
	bird.next.connect(_ready)
	get_tree().current_scene.add_child(bird)
