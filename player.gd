extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_CHARGE_TIME = 0.5
const FLOOR_FRICTION = 2000.0
const LAUNCH_SPEED = 900
var dashing_status = 0
var dashes_left = 0
var dash_vector = Vector2.ZERO
var dash_time = 0.0


func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, FLOOR_FRICTION * delta)
	# Add the gravity.
	if not is_on_floor() and dashing_status == 0:
		velocity += get_gravity() * delta

	# Handle jump.
	#if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("jump")) and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var xdirection := Input.get_axis("left", "right")
	var ydirection := Input.get_axis("up", "down")
	#if dashing_status == 0:
		#if xdirection:
			#velocity.x = xdirection * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
	#else:
		#velocity.x = 0
		#velocity.y = 0
	# DASH mechanic trial
	if Input.is_action_just_released("dash") and dashing_status == 1:
		dashing_status = 0
		var dash_direction := Vector2(xdirection, -1).normalized()
		var power: float = max(dash_time / MAX_CHARGE_TIME, 0.25)
		velocity = dash_direction * LAUNCH_SPEED * power
		
		
	if Input.is_action_just_pressed("dash") and is_on_floor():
		dash_time = 0
		dashing_status = 1
		
	if dashing_status == 1:
		velocity = Vector2.ZERO
		dash_time = min(dash_time + delta, MAX_CHARGE_TIME)
		
	var pre_slide_velocity := velocity

	move_and_slide()
	if is_on_wall_only():
		velocity.x = -pre_slide_velocity.x * 0.6
