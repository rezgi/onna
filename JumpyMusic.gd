extends Node

"""
A test scene for triggering music layers in sync with tempo

- additional clic when stop tempo
- full riff loops at measure_count 5 since counting starts with 1
- make all buttons toggle off when stop all
- code need refactoring for less repetition
- turn buttons to toggle_mode
"""

signal measure_start

onready var btn_MainRiff := $MarginContainer/VBoxContainer/BTN_MainRiff
onready var btn_Beat01 := $MarginContainer/VBoxContainer/BTN_Beat01
onready var btn_Beat02 := $MarginContainer/VBoxContainer/BTN_Beat02
onready var btn_Beat03 := $MarginContainer/VBoxContainer/BTN_Beat03
onready var btn_Melody := $MarginContainer/VBoxContainer/BTN_Melody
onready var btn_Bass := $MarginContainer/VBoxContainer/BTN_Bass
onready var tempo := $MarginContainer/Tempo

var MainRiff_toggle := false
var Beat01_toggle := false
var Beat02_toggle := false
var Beat03_toggle := false
var Melody_toggle := false
var Bass_toggle := false

func _ready():
	tempo.connect("tempo_on", self, "_on_tempo_signal")
	
	btn_MainRiff.text = "Play Main Riff"
	btn_MainRiff.rect_min_size = Vector2(300,50)
	
	btn_Beat01.text = "Play Beat 01"
	btn_Beat01.rect_min_size = Vector2(300,50)
	
	btn_Beat02.text = "Play Beat 02"
	btn_Beat02.rect_min_size = Vector2(300,50)
	
	btn_Beat03.text = "Play Beat 03"
	btn_Beat03.rect_min_size = Vector2(300,50)
	
	btn_Melody.text = "Play Melody"
	btn_Melody.rect_min_size = Vector2(300,50)
	
	btn_Bass.text = "Play Bass"
	btn_Bass.rect_min_size = Vector2(300,50)

func _on_tempo_signal(_tempo):
	print(_tempo.measure_count)
	if _tempo.is_full and (_tempo.measure_count - 1) % 4 == 0:
		emit_signal("measure_start")

func _on_BTN_MainRiff_pressed():
	tempo.start_timer()
	MainRiff_toggle = !MainRiff_toggle
	if MainRiff_toggle:
		$MainRiff.play()
		btn_MainRiff.text = "Stop Main Riff"
	else:
		tempo.timer.stop()
		$MainRiff.stop()
		$Beat01.stop()
		$Beat02.stop()
		$Beat03.stop()
		$Melody.stop()
		$Bass.stop()
		btn_MainRiff.text = "Play Main Riff"
		


func _on_BTN_Beat01_pressed():
	Beat01_toggle = !Beat01_toggle
	if Beat01_toggle:
		yield(self, "measure_start")
		$Beat01.play()
		btn_Beat01.text = "Stop Beat01"
	else:
		$Beat01.stop()
		btn_Beat01.text = "Play Beat01"


func _on_BTN_Beat02_pressed():
	Beat02_toggle = !Beat02_toggle
	if Beat02_toggle:
		yield(self, "measure_start")
		$Beat02.play()
		btn_Beat02.text = "Stop Beat02"
	else:
		$Beat02.stop()
		btn_Beat02.text = "Play Beat02"


func _on_BTN_Beat03_pressed():
	Beat03_toggle = !Beat03_toggle
	if Beat03_toggle:
		yield(self, "measure_start")
		$Beat03.play()
		btn_Beat03.text = "Stop Beat03"
	else:
		$Beat03.stop()
		btn_Beat03.text = "Play Beat03"


func _on_BTN_Melody_pressed():
	Melody_toggle = !Melody_toggle
	if Melody_toggle:
		yield(self, "measure_start")
		$Melody.play()
		btn_Melody.text = "Stop Melody"
	else:
		$Melody.stop()
		btn_Melody.text = "Play Melody"


func _on_BTN_Bass_pressed():
	Bass_toggle = !Bass_toggle
	if Bass_toggle:
		yield(self, "measure_start")
		$Bass.play()
		btn_Bass.text = "Stop Bass"
	else:
		$Bass.stop()
		btn_Melody.text = "Play Bass"
