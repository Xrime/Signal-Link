extends Node2D

var scene : PackedScene =preload("res://Scenes/room_2.tscn")

func _on_button_2_pressed() -> void:
	var scene_instance = scene.instantiate()
	
	get_tree().root.add_child(scene_instance)
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	
	get_tree().current_scene =scene_instance
	
	#extends Node2D
#
#var scene: PackedScene = preload("res://scenes/levelh.tscn")
#
#func _on_link_button_pressed() -> void:
	## Instance the scene
	#var scene_instance = scene.instantiate()
	#
	## Add new scene to root
	#get_tree().root.add_child(scene_instance)
	#
	## Safely remove current scene if it exists
	#if get_tree().current_scene:
		#get_tree().current_scene.queue_free()
	#
	## Optional: set the new scene as current
	#get_tree().current_scene = scene_instance
#


func _on_button_pressed() -> void:
	get_tree().quit()
