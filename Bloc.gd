extends StaticBody2D

"""
A static bloc that moves according to tempo and options.

- Add back & forth option
- Add custom behavior, ex : move forward for 2 measures / wait 1 measure / move backward : 2 measures
- Add custom directions, ex : move 64 Y for 2 quart / move 64 X for 1 quart / move -64 Y for 2 quart / move -64 X for 1 quart
- Experiment with tween types
- Maybe invert directions on collision ?
"""

export var direction := Vector2.ZERO
export (int, "measure", "quart", "syncope", "eight") var move_on
export (int, "measure", "quart", "eight") var tween_duration

onready var tween := $Tween

func tempo_signal(tempo) -> void:
	match move_on:
		0:
			if tempo.is_full:
				move(direction, tween_duration(tempo.bpm))
		1:
			if tempo.is_quart:
				move(direction, tween_duration(tempo.bpm))
		2:
			if tempo.is_syncope:
				move(direction, tween_duration(tempo.bpm))
		3:
			if tempo.is_eight:
				move(direction, tween_duration(tempo.bpm))

func move(_direction, _duration) -> void:
	tween.interpolate_property(
		self, 
		'position',
		self.position, 
		self.position + _direction, 
		_duration, 
		Tween.TRANS_QUINT, 
		Tween.EASE_OUT
		)
	tween.start()

func tween_duration(bpm) -> float:
	var tempo_duration := 0.0
	match tween_duration:
		0:
			tempo_duration = 60.0 / (bpm / 2)
		1:
			tempo_duration = 60.0 / (bpm)
		2:
			tempo_duration = 60.0 / (bpm * 2)
	return tempo_duration

