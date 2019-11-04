extends KinematicBody2D

export var speed := 1000
export var distance := 64

var target = Vector2.ZERO
var move_vector := Vector2.ZERO
var store_tempo := 0
var has_moved := false

func _ready():
	position = get_viewport_rect().size / 2
	print(position)


func _physics_process(delta):
	if target != Vector2.ZERO:
		move_vector.y = ((target.y - position.y) * 0.2) / delta
#		move_vector.y = target.y - position.y
#		move_vector = move_vector.normalized() * speed
		print(move_vector)
		move_and_slide(move_vector)

func test_signal(tempo):
	if store_tempo != tempo.full:
		has_moved = !has_moved
		store_tempo = tempo.full
		if !has_moved:
			target = Vector2(0, position.y - distance)
		else:
			target = Vector2(0, position.y + distance)
	else:
		target = Vector2.ZERO
