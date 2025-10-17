extends CharacterBody3D

@onready var agent = $NavigationAgent3D
@export var patrol_points : Array[Node3D] = []
var current_point=0
var speed =3.0

func _ready() -> void:
	if patrol_points.size()>0:
		agent.target_position=patrol_points[current_point].global_position

func _physics_process(delta: float) -> void:
	if patrol_points.size()==0:
		return
	
	if agent.is_navigation_finished():
		current_point =(current_point+1)%patrol_points.size()
		agent.target_position=patrol_points[current_point].global_position
	var next_path_pos= agent.get_next_path_position()
	var direction = (next_path_pos - global_position).normalized()
	velocity =direction*speed
	move_and_slide()
	print(agent.get_next_path_position())
	if direction.length()>0.1:
		var target = global_transform.origin+direction
		var current =global_transform.basis.get_euler().y
		var target_root = atan2(-direction.x, -direction.z)
		var new = lerp_angle(current, target_root,delta*6.0)
		rotation.y=new
	
	
