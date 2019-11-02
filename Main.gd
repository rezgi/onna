extends Node2D

func _ready():
	$Beat.connect("tempo_on", $Player, "test_signal")
