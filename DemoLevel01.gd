extends Node2D

"""
Demo scene for testing basic musical game mechanic.
Testing : new music layers and level elements appear on reaching trigger areas

- player snap doesn't work, why
- make bloc movements synced with midi in animationPlayer
- make blocs back&forth after a certain nb of iterations

- add a riff count in tempo, later each song will have its own tempo
- make a counter when player reaches trigger before new riff
- respawn when leave screen
- func to connect and hide all blocs
"""

signal new_riff

func _ready():
	$Tempo.connect("tempo_on", self, "_on_tempo_signal")
	$Bloc01.visible = false
	$Bloc03.visible = false
	


func _on_TriggerMainRiff_body_entered(body):
	$TriggerMainRiff.queue_free()
	$Tempo.start_timer()
	$DemoMusic/MainRiff.play()
	
	$Tempo.connect("tempo_on", $Bloc01, "tempo_signal")
	$Bloc01.visible = true


func _on_TriggerBeat01_body_entered(body):
	yield(self, "new_riff")
	$DemoMusic/Beat01.play()
	$TriggerBeat01.queue_free()
	
#	$Tempo.connect("tempo_on", $Bloc03, "tempo_signal") # creates an error, not needing tempo for the time being
	$Bloc03.visible = true
	$Bloc03/KinematicBody2D/AnimationPlayer.play("move_right")

func _on_tempo_signal(tempo):
	if tempo.is_full and (tempo.measure_count - 1) % 4 == 0:
		emit_signal("new_riff")
