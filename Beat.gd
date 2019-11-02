extends Node2D

"""
Metronome scene that takes a tempo (bpm) in the inspector and emits a signal with a dictionary 
counting the full measure, the quarter notes and the eight notes.

Sound can be activated for debugging in inspector.
"""

signal tempo_on

export var bpm := 120
# warning-ignore:unused_class_variable
export var sound_debug := false

var count_eight := 0
var tempo = {"full" : 0, "quart" : 1, "eight" : 1}

func _ready():	
	$mainTempo.wait_time = bpm2sec(bpm * 2.0)
	$mainTempo.start()


func bpm2sec(beat) -> float:
	return 60.0 / beat


func _on_mainTempo_timeout():
	if count_eight % 8 == 0:
		tempo.full += 1
		tempo.quart = 1
		tempo.eight = 1
		$metronome01.volume_db = 0
		$metronome01.play() if sound_debug else ""
	elif count_eight % 2 == 0:
		tempo.quart += 1
		$metronome01.volume_db = -10
		$metronome01.play() if sound_debug else ""
	else:
		$metronome02.play() if sound_debug else ""
	
	emit_signal("tempo_on", tempo)
#	print(tempo)
	tempo.eight += .5
	count_eight += 1
	$mainTempo.start()
