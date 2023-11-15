extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var animatedPlayer = $AnimationPlayer
var speed: float = 200

signal next

func _random_direction():
	var x = deg_to_rad(randf_range(0,180))
	return Vector2(cos(x),sin(x)).normalized()

func _ready():
	input_pickable = true
	velocity = _random_direction() * speed

func _flip_check():
	if velocity.x < 0:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
	_flip_check()

func _death():
	velocity = Vector2.ZERO
	animatedPlayer.play("death")
	await get_tree().create_timer(1).timeout
	velocity = Vector2.DOWN * 150

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("shoot"):
		_death()


func _on_visible_on_screen_notifier_2d_screen_exited():
	next.emit()
	queue_free()