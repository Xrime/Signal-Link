extends Node2D

var scene_path := "res://Scenes/room_2.tscn"

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(scene_path)

func _on_button_pressed() -> void:
	get_tree().quit()
