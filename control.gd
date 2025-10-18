extends Control
var seconds =0
var minute =0
var Dseconds =30
var Dminute  =1


func _ready() -> void:
	reset_timer()
	pass
	
func _on_timer_timeout() -> void:
	if seconds==0:
		if minute >0:
			minute-=1
			seconds=60
	seconds-=1
	$Label.text=String(minute)+"+"+String(seconds)
	pass # Replace with function body.

func reset_timer():
	seconds=Dseconds
	minute=Dminute
