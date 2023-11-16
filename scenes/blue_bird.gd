extends CharacterBody2D
class_name blue_bird

@onready var animatedSprite = $AnimatedSprite2D_blue
@onready var animatedPlayer = $AnimationPlayer_blue
var speed: float = 300
signal exit

func random_direction():
	var x = deg_to_rad(randf_range(0,180))
	#return Vector2(1,0)
	#return Vector2(0,-1)
	return Vector2(cos(x),sin(x)).normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#input_pickable = true
	#velocity = random_direction() * speed
	#print(velocity)

func launch():
	input_pickable = true
	velocity = random_direction() * speed
	print(velocity)

func flip_check():
	if velocity.x < 0:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		print(velocity)
	flip_check()

func kill():
	velocity = Vector2.ZERO
	animatedPlayer.play("death")
	await get_tree().create_timer(1).timeout
	velocity = Vector2.DOWN * 150

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("shoot"):
		kill()

func _on_visible_on_screen_notifier_2d_screen_exited():
	exit.emit()
	queue_free()
