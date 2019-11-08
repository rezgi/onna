extends KinematicBody2D

"""
Moves character according to tempo and direction.
In the future have more modular movement loops, ex: move then stay still one beat, then back / move x then y on next beat
"""

export var distance := 64
export var direction := Vector2(0, 1)
export (bool) var move_on_measure = true
export (bool) var move_on_quart = false
export (bool) var move_on_syncope = false
export (bool) var move_on_eight = false
export (float, 1) var SPEED = 0.2

var target = Vector2.ZERO
var move_vector := Vector2.ZERO
var measure_count := 0
var has_moved := false

func _ready():
#	position = get_viewport_rect().size / 2
	position = Vector2(512,512)

func _physics_process(delta):
	if target != Vector2.ZERO:
		move_vector = ((target - position) * SPEED) / delta
		print(move_vector)
		move_and_collide(move_vector * delta)

func beat_signal(tempo):
	if move_on_measure:
		count_full_measure(tempo)
	elif move_on_quart:
		count_quart_measure(tempo)
	elif move_on_syncope:
		count_syncope_measure(tempo)
	elif move_on_eight:
		count_eight_measure(tempo)
	else:
		return

func compute_target():
	var new_distance
	if has_moved:
		new_distance = -distance
	else:
		new_distance = distance

	if direction.x != 0:
		target.x = position.x + (new_distance * direction.x)
	else:
		target.x = position.x
	if direction.y != 0:
		target.y = position.y + (new_distance * direction.y)
	else:
		target.y = position.y
	return target

func count_full_measure(tempo):
	if measure_count != tempo.full:
		measure_count = tempo.full
		has_moved = !has_moved
		compute_target()
	else:
		target = Vector2.ZERO

func count_quart_measure(tempo):
	if !tempo.syncope:
		has_moved = !has_moved
		compute_target()
	else:
		target = Vector2.ZERO

func count_syncope_measure(tempo):
	if tempo.syncope:
		has_moved = !has_moved
		compute_target()
	else:
		target = Vector2.ZERO

func count_eight_measure(tempo):
	has_moved = !has_moved
	compute_target()
