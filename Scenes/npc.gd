extends CharacterBody3D

@onready var agent = $NavigationAgent3D
@export var patrol_points : Array[Node3D] = []
@export var patrol_speed :=3.0
@export var chase_speed := 5.0
@export var alert_duration := 6.0
@onready var player =get_tree().get_first_node_in_group("Player")
var current_point=0
var speed =3.0
var chasing =false
var alert_timer =0.0
var player_has_wire =false
var direction :Vector3 = Vector3.ZERO

var player_in_light = false


func _ready() -> void:
	agent.path_max_distance = 100.0
	agent.path_desired_distance = 0.5
	agent.target_desired_distance = 0.5
	agent.avoidance_enabled = true
	agent.set_navigation_map(get_world_3d().navigation_map)
	
	if patrol_points.size() > 0:
		agent.target_position = patrol_points[current_point].global_position
		

func _physics_process(delta: float) -> void:
	if patrol_points.size()==0:
		return
	
	if player and  "carrying_wire" in player:
		player_has_wire =player.carrying_wire
	else:
		player_has_wire=false
	if player_has_wire:
		chasing=true
		alert_timer=0.0
	else:
		if chasing:
			alert_timer +=delta
			if alert_timer > alert_duration:
				chasing=false
				agent.target_position =patrol_points[current_point].global_position
	if chasing:
		if not player.carrying_wire:
			return
		agent.target_position =player.global_position
		var next_path_pos =agent.get_next_path_position()
		direction = (next_path_pos -global_position).normalized()
		velocity=direction*chase_speed
		move_and_slide()
	else :
		if agent.is_navigation_finished():
			current_point =(current_point+1)%patrol_points.size()
			agent.target_position=patrol_points[current_point].global_position
		var next_path_pos= agent.get_next_path_position()
		direction = (next_path_pos - global_position).normalized()
		velocity =direction*speed
		move_and_slide()
	print(agent.get_next_path_position())
	if direction.length() > 0.1:
		var current = global_transform.basis.get_euler().y
		var target_root = atan2(-direction.x, -direction.z)
		var new = lerp_angle(current, target_root, delta * 6.0)
		rotation.y = new



		
