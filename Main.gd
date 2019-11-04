extends Node2D

func _ready():
	$Beat.connect("tempo_on", $Player, "beat_signal")
