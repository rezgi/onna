extends Node2D

"""
Metronome scene that takes a tempo (bpm) in the inspector and emits a signal with a dictionary 
counting the full measure, the quarter notes and the syncope notes.

Sound can be activated for debugging in inspector.
"""

signal tempo_on

export var bpm := 120
export var play_full_measure := true
export var play_quart := true
export var play_syncope := true
export var play_eight := false
export var sound_debug := true

var counter := 0
var tempo = {"full" : 0, "quart" : 1, "syncope" : null, "eight": 0}

func _ready():	
	$mainTempo.wait_time = bpm2sec(bpm * 2.0)
	$mainTempo.start()
	$BGM.play()


func bpm2sec(beat) -> float:
	return 60.0 / beat


func _on_mainTempo_timeout():
	if counter % 8 == 0:
		tempo.full += 1
		tempo.quart = 1
		tempo.syncope = null
		counter = 0
		
		if sound_debug and play_full_measure:
			$metronome01.volume_db = 0
			$metronome01.play()
	elif counter % 2 == 0:
		tempo.quart += 1
		tempo.syncope = null
		
		if sound_debug and play_quart:
			$metronome01.volume_db = -10
			$metronome01.play()
	else:
		tempo.syncope = tempo.quart + .5
		
		if sound_debug and play_syncope:
			$metronome02.play()
	
	if sound_debug and play_eight:
		$metronome01.volume_db = -20
		$metronome01.play()
	
	emit_signal("tempo_on", tempo)
	
	tempo.eight = counter + 1
	counter += 1
	$mainTempo.start()
