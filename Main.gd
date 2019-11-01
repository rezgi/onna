extends Node2D

func _ready():
	$Beat.connect("tempo_beat", self, "test_signal")

func test_signal(tempo):
	print(tempo)
