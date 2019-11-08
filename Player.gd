extends KinematicBody2D

var vel := Vector2.ZERO
const UP := Vector2.UP

export var speed := 200
export var max_speed := 800
export var gravity := 100
export var jump_height := 1000

func _physics_process(delta):
	vel.y += gravity
	if Input.is_action_pressed("ui_right"):
		vel.x = min(vel.x + speed, max_speed)
	elif Input.is_action_pressed("ui_left"):
		vel.x = max(vel.x - speed, -max_speed)
	else:
		vel.x = 0
	
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		vel.y = -jump_height
	
	if !is_on_floor():
		pass
	
	if position.y > 4000:
		get_tree().quit()
	
	vel.x = lerp(vel.x, 0, .1)
	vel = move_and_slide(vel, UP)
