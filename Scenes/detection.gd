extends Area3D

@onready var game_over_ui = get_tree().get_first_node_in_group("GameOverUI")  # optional

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Make sure your player is in the “player” group
		print("Player detected in light!")
		game_over()

func game_over():
	get_tree().paused = true
	if game_over_ui:
		game_over_ui.visible = true
	else:
		print("GAME OVER")  # fallback
