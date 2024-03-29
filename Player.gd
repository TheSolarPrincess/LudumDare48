extends KinematicBody2D


const MOVE_SPEED = 500
const JUMP_ACCEL = 400
const GRAVITY = 20
const JUMP_CD = 0.1
const MAX_FALL_SPEED = 1000

var y_velocity = 0
var jump_cd = 0

var is_dead = false

func _physics_process(delta):
	if is_dead: return
	
	var move_dir = 0
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	move_and_slide(Vector2(MOVE_SPEED*move_dir, y_velocity), Vector2(0,-1 ))
		
	if move_dir == -1:
		$Sprite.flip_h = false
	if move_dir == 1:
		$Sprite.flip_h = true
		
	jump_cd -= delta
	
	var grounded = is_on_floor()
	y_velocity += GRAVITY
	if jump_cd < 0 and Input.is_action_just_pressed("jump"):
		y_velocity -= JUMP_ACCEL
		jump_cd = JUMP_CD
	if grounded and y_velocity >= 5:
		y_velocity = 5
	if y_velocity >= MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED
	if is_on_ceiling() and y_velocity < -5:
		y_velocity = -5
	

func die():
	$Sprite.visible = false
	$Particles2D.emitting = true
	is_dead = true
	get_tree().get_nodes_in_group("gameoverscreen")[0].show(get_tree().get_nodes_in_group("UI")[0].score)
