extends KinematicBody2D


const MOVE_SPEED = 500
const JUMP_ACCEL = 500
const GRAVITY = 20

var y_velocity = 0

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	move_and_slide(Vector2(MOVE_SPEED*move_dir, y_velocity), Vector2(0,-1 ))
		
	var grounded = is_on_floor()
	y_velocity += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velocity -= JUMP_ACCEL
	if grounded and y_velocity >= 5:
		y_velocity = 5
	
