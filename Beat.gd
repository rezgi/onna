extends Node2D

"""
Metronome scene that takes a tempo (bpm) in the inspector and emits a signal with a dictionary 
counting the full measure, the quarter notes and the syncope notes.

Sound can be activated for debugging in inspector.
"""

signal tempo_on

export var bpm := 120
export var sound_debug := false

var counter := 0
var tempo = {"full" : 0, "quart" : 1, "syncope" : null, "eight": 0}

func _ready():	
	$mainTempo.wait_time = bpm2sec(bpm * 2.0)
	$mainTempo.start()


func bpm2sec(beat) -> float:
	return 60.0 / beat


func _on_mainTempo_timeout():
	if counter % 8 == 0:
		tempo.full += 1
		tempo.quart = 1
		tempo.syncope = null
		counter = 0
		$metronome01.volume_db = 0
		$metronome01.play() if sound_debug else ""
	elif counter % 2 == 0:
		tempo.quart += 1
		tempo.syncope = null
		$metronome01.volume_db = -10
		$metronome01.play() if sound_debug else ""
	else:
		tempo.syncope = tempo.quart + .5
		$metronome02.play() if sound_debug else ""
	
	emit_signal("tempo_on", tempo)
	
	tempo.eight = counter + 1
	counter += 1
	$mainTempo.start()
