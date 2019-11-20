extends Node2D
class_name Tempo, "res://ui/tempo.png"

"""
A new and cleaner tempo algorythm. Sends an updated dictionary on each beat.

- BGM loop not perfect, check sound file.
- Bug on first full_measure sound when ternary. To find.
- If clic again on start, bug. need to reset the counter in this case
- Stop button in Jumpy scene acts weird, clic area displaced
- Refactor sound playing in a single function with condition check
"""

signal tempo_on

export var bpm := 120
export var debug_bgm := true
export var all_beats_sound := true
export var measure_sound := false
export var quart_sound := false
export var syncope_sound := false
export (int, "Binary", "Ternary") var signature_type

onready var high_clic := $highClic
onready var low_clic := $lowClic
onready var timer := $Timer
onready var bgm := $BGM

var counter := 1.0
var signature := 0.0
var tempo := {
	"bpm": null,
	"is_full": false,
	"is_quart": false,
	"is_syncope": false,
	"is_eight": false,
	"measure_count": 1,
	"quart_count": 1,
	"syncope_count": 1.5,
	"beat_count": 1
}

func _on_StartTempo_pressed() -> void:
	start_timer()

func _on_Timer_timeout() -> void:
	if counter == signature:
		if measure_sound: play_measure()
		if all_beats_sound: play_beat()
		reset_measure()
	else:
		if all_beats_sound: play_beat()
		counter += .5
		tempo.is_full = false
		tempo.beat_count += 1
	
	if step_decimals(counter) > 0:	# Detects if counter is float (syncope) or integer (quart)
		tempo.is_quart = false
		tempo.is_syncope = true
		tempo.syncope_count = counter
		if syncope_sound: play_syncope()
#		print("syncope : ", counter)
	else:
		tempo.is_quart = true
		tempo.is_syncope = false
		tempo.quart_count = counter
		if quart_sound: play_quart()
#		print("quart : ", counter)
	
#	print(tempo)
	emit_signal("tempo_on", tempo)
	timer.start()

func _on_StopTempo_pressed() -> void:
	stop_timer()

func start_timer() -> void:
	timer.wait_time = 60.0 / (bpm * 2)
	timer.start()
	
	if all_beats_sound: play_beat()
	if quart_sound: play_quart()
	if debug_bgm: bgm.play()
	
	signature = 4.5 if signature_type == 0 else 3.5
	tempo.bpm = bpm
	tempo.is_quart = true
	tempo.is_eight= true
#	print(tempo)
	emit_signal("tempo_on", tempo)

func stop_timer() -> void:
	timer.stop()
	if debug_bgm: bgm.stop()
	reset_tempo_dict()
	counter = 1.0

func reset_measure() -> void:
	counter = 1
	tempo.beat_count = 1
	tempo.measure_count += 1
	tempo.is_full = true

func reset_tempo_dict() -> void:
	tempo.bpm = null
	tempo.is_full = false
	tempo.is_quart = false
	tempo.is_syncope = false
	tempo.is_eight= false
	tempo.measure_count = 1
	tempo.quart_count = 1
	tempo.syncope_count = 1.5
	tempo.beat_count = 1

func play_beat() -> void:
	if all_beats_sound: $highClic.volume_db = -20
	$highClic.play()

func play_measure() -> void:
	if measure_sound: $lowClic.volume_db = -5
	$lowClic.play()

func play_quart() -> void:
	if quart_sound: $highClic.volume_db = -10
	$highClic.play()

func play_syncope() -> void:
	if syncope_sound: $lowClic.volume_db = -20
	$lowClic.play()
