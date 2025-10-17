extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		body.near_terminal_b = true
		print("Player entered Terminal B")

func _on_body_exited(body):
	if body.name == "Player":
		body.near_terminal_b = false
		print("Player exited Terminal B")
