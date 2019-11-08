extends Node2D

func _ready():
	var blocs = $BlocsContainer.get_children()
	for i in blocs:
		$Beat.connect("tempo_on", get_node("BlocsContainer/" + i.name), "beat_signal")
