extends Node2D

func _ready():
	$Beat.connect("tempo_on", self, "test_signal")

func test_signal(tempo):
	print(tempo)