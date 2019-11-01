extends Node2D

"""
Metronome scene that takes a tempo (bpm) in the inspector and emits a signal with a dictionary 
counting the full measure, the quarter notes and the eight notes.

- optional label beats visualisation
- bug with eight notes that get delayed over 150bpm
"""

export var bpm := 120
signal tempo_beat
var count_eight := 1
var tempo = {"full" : 0, "quart" : 0, "eight" : 0.5}

func _ready():	
	$fullTimer.wait_time = bpm2sec(bpm / 4.0)
	$quartTimer.wait_time = bpm2sec(bpm)
	$eightTimer.wait_time = bpm2sec(bpm * 2.0)
	
	$fullTimer.start()
	$quartTimer.start()
	$eightTimer.start()


func bpm2sec(beat) -> float:
	return 60.0 / beat
#	var result = 60.0 / beat
#	print(result)
#	var test = stepify(60.0 / beat, 0.01)
#	print(test)
#	return test


func _on_fullTimer_timeout() -> void:
	$metronome03.play()
	tempo.full += 1
	tempo.quart = 0
	tempo.eight = 0.5
	$fullTimer.start()
	$labelFull.text = str(tempo.full)


func _on_quartTimer_timeout()  -> void:
	$metronome01.play()
	$quartTimer.start()
	tempo.quart += 1
	$labelQuart.text = str(tempo.quart)


func _on_eightTimer_timeout()  -> void:
	if count_eight % 2 == 1:
		$metronome02.play()
		tempo.eight += 1
	
	count_eight += 1
	emit_signal("tempo_beat", tempo)
	$eightTimer.start()
	
	$labelEight.text = str(tempo.eight)


"""
func round_to(value, decimal_places):
    value factor = pow(10, decimal_places)
    return round(value * factor) / factor
 
func round_to_dec(num, digit):
    return round(num * pow(10.0, digit)) / pow(10.0, digit)
"""
