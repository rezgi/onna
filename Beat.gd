extends Node2D

export var bpm := 120

func _ready():
	$fullMeasure.visible = false
	$quarterMeasure.visible = false
	$eightMeasure.visible = false
	
	$fullTimer.wait_time = bpm2sec(bpm / 4.0)
	$quartTimer.wait_time = bpm2sec(bpm)
	$eightTimer.wait_time = bpm2sec(bpm * 2.0)
	
	$fullTimer.start()
	$quartTimer.start()
	$eightTimer.start()

func bpm2sec(tempo) -> float:
	return 60.0/tempo

func _on_fullTimer_timeout():
	$metronome03.play()
	$fullMeasure.visible = true
	$fullTimer.start()
	$fullMeasureDisplay.start()


func _on_quartTimer_timeout():
	$metronome01.play()
	$quarterMeasure.visible = !$quarterMeasure.visible
	$quartTimer.start()


func _on_eightTimer_timeout():
	$metronome02.volume_db = -10
	$metronome02.play()
	$eightMeasure.visible = !$eightMeasure.visible
	$eightTimer.start()


func _on_fullMeasureDisplay_timeout():
	$fullMeasure.visible = false
