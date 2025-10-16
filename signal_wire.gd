extends Node3D

@onready var path : Path3D = $Path3D
@onready var follow : PathFollow3D=$Path3D/PathFollow3D
var curve :=Curve3D.new()

var start_point: Vector3
var end_point: Vector3
var is_active := false

func _ready() -> void:
	path.curve =curve
	start_point=global_position
	end_point= global_position
	
func _process(delta: float) -> void:
	if is_active:
		update_wire()
		
func update_wire():
	curve.clear_points()
	var mid_point = (start_point+end_point) / 2.0
	mid_point.y +=0.5
	
	curve.add_point(start_point)
	curve.add_point(mid_point)
	curve.add_point(end_point)

	path.curve = curve

	# Position the visual wire
	var distance = start_point.distance_to(end_point)
	follow.progress_ratio = 1.0
	var mesh = follow.get_node("MeshInstance3D")
	mesh.scale = Vector3(0.05, distance / 2.0, 0.05)
	mesh.position = (start_point + end_point) / 2.0
	
