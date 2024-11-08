extends KinematicBody2D

export var speed = 400
export var gravity = 800
export var jump_velocity = -350
var velocity = Vector2()

var screen_size = Vector2()


func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	# Reset horizontal velocity every frame
	velocity.x = 0
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		$AnimatedSprite.flip_h = true # Face right
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
		$AnimatedSprite.flip_h = false # Face left

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Gravity effect
	velocity.y += gravity * delta

	# Apply movement
	velocity = move_and_slide(velocity, Vector2.UP)

	# Animation handling
	if velocity.x != 0:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.stop()
