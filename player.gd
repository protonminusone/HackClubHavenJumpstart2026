extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dashing_status = 0
var dashes_left = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and dashing_status == 0:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xdirection := Input.get_axis("left", "right")
	var ydirection := Input.get_axis("jump", "down")
	if xdirection:
		velocity.x = xdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# DASH mechanic trial
	if Input.is_action_just_pressed("dash"):
		dashing_status = 1
		velocity.x = xdirection * SPEED * 15
		velocity.y = ydirection * JUMP_VELOCITY * -1
		dashing_status = 0

	move_and_slide()
