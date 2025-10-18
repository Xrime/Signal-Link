extends CharacterBody3D

@onready var agent = $NavigationAgent3D
@export var patrol_points : Array[Node3D] = []
@export var patrol_speed :=3.0
@export var chase_speed := 5.0
@export var detention_range:=10.0
@export var vision_angle := 45.0
@onready var player =get_tree().get_first_node_in_group("Player")
var current_point=0
var speed =3.0
var chasing =false
var lost_timer =0.0
var max_lost_time=3.0
var direction :Vector3 = Vector3.ZERO

func _ready() -> void:
	if patrol_points.size()>0:
		agent.target_position=patrol_points[current_point].global_position

func _physics_process(delta: float) -> void:
	if patrol_points.size()==0:
		return
	if chasing:
		if not player.carrying_wire:
			return
		agent.terget_position =player.global_position
		var next_path_pos =agent.get_next_path_position()
		var direction = (next_path_pos -global_position)
		velocity=direction*chase_speed
		move_and_slide()
	else :
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

func check_detection(delta):
	if not player:
		return
	var to_player=player.global_position -global_position
	var distance = to_player.length()
	var direction_to_player =to_player.normalized()
	var forward = -transform.basis.z
	var angle_differnt = rad_to_deg(acos(forward.dot(direction_to_player)))
	
	if distance < detention_range and angle_differnt< vision_angle/2.0:
		chasing =true
		lost_timer += delta
	else:
		if chasing:
			lost_timer+=delta
			if lost_timer > max_lost_time:
				chasing =false
				agent.target_position =patrol_points[current_point].global_position
	
	

	
	
