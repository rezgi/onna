extends KinematicBody2D

export var speed := 1000
export var target = Vector2.ZERO
export var distance := 64

var move_vector := Vector2.ZERO
var store_tempo := 0
var has_moved := false
var initial_position := Vector2.ZERO

func _ready():
	var screen_size = get_viewport_rect().size
	initial_position = screen_size / 2
	position = initial_position


func _physics_process(delta):
	if target != Vector2.ZERO:
		move_vector.y = target.y - position.y
		print("before : ", move_vector)
		move_vector = move_vector.normalized() * speed
		print("after : ", move_vector)
		move_and_slide(move_vector)

func test_signal(tempo):
	if store_tempo != tempo.full:
		store_tempo = tempo.full
		if !has_moved:
			target = Vector2(0, initial_position.y - distance)
			has_moved = true
		else:
			target = Vector2(0, initial_position.y + distance)
			has_moved = false
	else:
		target = Vector2.ZERO
