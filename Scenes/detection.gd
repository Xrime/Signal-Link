extends Area3D

@onready var game_over_ui = get_tree().get_first_node_in_group("GameOverUI")  # optional
var gameover : PackedScene =preload("res://GameOver.tscn")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Make sure your player is in the “player” group
		print("Player detected in light!")
		game_over()

func game_over():
	if game_over_ui:
		var scene_instance = gameover.instantiate()
		get_tree().root.add_child(scene_instance)
		if get_tree().current_scene:
			get_tree().current_scene.queue_free()
			get_tree().current_scene =scene_instance
	else:
		print("GAME OVER")  # fallback
