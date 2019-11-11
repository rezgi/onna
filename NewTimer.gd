extends Node2D

"""
A new and cleaner tempo algorythm. Sends an updated dictionary on each beat.

- add debug sound for measure / quart / syncope / all
- add debug BGM option
- add counter to dictionary
- add signature : 4/4 and 3/3 (if == 3.5 instead of 4.5) option
"""

signal tempo_on

export var bpm := 120
export var debut_sound := true

onready var high_clic = $highClic
onready var low_clic = $lowClic
onready var timer = $Timer
onready var bgm = $BGM

var counter := 1.0
var tempo = {
	"is_full": false,
	"is_quart": false,
	"is_syncope": false,
	"measure_count": 1,
	"quart_count": 1,
	"syncope_count": 1.5
}

func _on_StartTempo_pressed():
	start_timer()

func _on_Timer_timeout():
	if counter == 4.5:
		low_clic.play()
		reset_measure()
	else:
		high_clic.play()
		counter += .5
		tempo.is_full = false
	
	if step_decimals(counter) > 0:	# Detects if counter is float (syncope) or integer (quart)
		tempo.is_quart = false
		tempo.is_syncope = true
		tempo.syncope_count = counter
	else:
		tempo.is_quart = true
		tempo.is_syncope = false
		tempo.quart_count = counter
	
#	print(tempo)
	emit_signal("tempo_on", tempo)
	timer.start()

func _on_StopTempo_pressed():
	timer.stop()
	bgm.stop()

func start_timer():
	timer.wait_time = bpm_to_sec(bpm)
	timer.start()
	
	low_clic.play()
	bgm.play()
	
	tempo.is_quart = true
	emit_signal("tempo_on", tempo)
	
#	print(tempo)

func bpm_to_sec(_bpm):
	return 60.0 / (_bpm * 2)

func reset_measure():
	counter = 1
	tempo.measure_count += 1
	tempo.is_full = true
