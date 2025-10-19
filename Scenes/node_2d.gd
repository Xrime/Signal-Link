extends Node2D

@onready var timer_label = $Control/CanvasLayer/Label
var gameover : PackedScene =preload("res://GameOver.tscn")
@export var start_time: float = 5
var time_left: float
var running := true

func _ready() -> void:
	time_left = start_time*60
	_update_timer_label()
	print("Timer started! Label position:", timer_label.global_position)


func _process(delta: float) -> void:
	if not running:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		running = false
		var scene_instance = gameover.instantiate()
		get_tree().root.add_child(scene_instance)
		if get_tree().current_scene:
			get_tree().current_scene.queue_free()
			get_tree().current_scene =scene_instance

func _update_timer_label() -> void:
	var minutes = int(time_left / 60)
	var seconds = int(time_left) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
