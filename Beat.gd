extends Node2D

# full : 4/4
# quarter : 1/4
# eight : .5/4

# 1s == 60bpm

onready var metronome01 := $metronome01
onready var sprite := $sprite

export var bpm := 120

func _ready():
	$Timer.wait_time = bpm2sec(bpm)
	$Timer.start()
	
	sprite.visible = false
	sprite.position = get_viewport_rect().size/2

func _on_Timer_timeout():
	sprite.visible = !sprite.visible
	metronome01.play()
	$Timer.start()

func get_sprite_center(spr: Sprite) -> Vector2:
	var spr_center = spr.get_rect().size
	return spr_center/2

func bpm2sec(tempo) -> float:
	return 60.0/tempo
