extends CharacterBody3D

@export var speed := 5.0
@export var mouse_sensitivity :=0.3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction := Vector3.ZERO

func _physics_process(delta: float) -> void:
	var input_direction = Vector3.ZERO
	if Input.is_action_pressed("Up"):
		input_direction.z -=1
	if Input.is_action_pressed("Down"):
		input_direction.z +=1
	if Input.is_action_pressed("Right"):
		input_direction.x+=1
	if Input.is_action_pressed("Left"):
		input_direction.x -= 1 
	
	input_direction = input_direction.normalized()
	direction = (transform.basis * input_direction).normalized()
	velocity.x=direction.x * speed
	velocity.z =direction.z * speed
	if not is_on_floor():
		velocity.y -= gravity*delta
	move_and_slide()
