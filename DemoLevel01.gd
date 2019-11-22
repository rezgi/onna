extends Node2D

"""
Demo scene for testing basic musical game mechanic.
Testing : new music layers and level elements appear on reaching trigger areas

- animate collision shapes too
- add a riff count in tempo, later each song will have its own tempo
- make a counter when player reaches trigger before new riff
- respawn when leave screen
- func to connect and hide all blocs (use groups)
"""

signal new_riff

func _ready():
	$Tempo.connect("tempo_on", self, "_on_tempo_signal")
	$BlocMainRiff.visible = false
	$BlocBass.visible = false
	$BlocBeat01.visible = false
	


func _on_TriggerMainRiff_body_entered(body):
	$TriggerMainRiff.queue_free()
	$Tempo.start_timer()
	$DemoMusic/MainRiff.play()
	
	$BlocMainRiff.visible = true
	$BlocMainRiff/KinematicBody2D/AnimationPlayer.play("move")


func _on_tempo_signal(tempo):
	if tempo.is_full and (tempo.measure_count - 1) % 4 == 0:
		emit_signal("new_riff")


func _on_TriggerBass_body_entered(body):
	yield(self, "new_riff")
	$DemoMusic/Bass.play()
	$TriggerBass.queue_free()
	
	$BlocBass.visible = true
	$BlocBass/KinematicBody2D/AnimationPlayer.play("move")


func _on_TriggerBeat01_body_entered(body):
	yield(self, "new_riff")
	$DemoMusic/Beat01.play()
	$TriggerBeat01.queue_free()
	
	$BlocBeat01.visible = true
	$BlocBeat01/KinematicBody2D/AnimationPlayer.play("move")
