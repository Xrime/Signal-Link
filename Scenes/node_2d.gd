extends Node2D

@onready var timer_label = $CanvasLayer/Label

@export var start_time: float = 60.0
var time_left: float
var running := true

func _ready() -> void:
	time_left = start_time
	_update_timer_label()
	print("Timer started! Label position:", timer_label.global_position)


func _process(delta: float) -> void:
	if not running:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		running = false
	_update_timer_label()

func _update_timer_label() -> void:
	var minutes = int(time_left / 60)
	var seconds = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
