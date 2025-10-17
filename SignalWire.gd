extends Node3D
class_name SignalWire

@onready var mesh: MeshInstance3D = $MeshInstance3D
@export var pickup_radius := 3.0
var picked_up := false
var is_active := false

func _ready():
	add_to_group("SignalWire")
	if mesh:
		mesh.show()

func pick_up(player_pos: Vector3) -> void:
	global_transform.origin = player_pos
	picked_up = true
	is_active = true
	print("Wire picked up")

func update_position(player_pos: Vector3) -> void:
	if is_active:
		global_transform.origin = player_pos

func drop(at_terminal: bool) -> void:
	is_active = false
	picked_up = false
	if at_terminal:
		print("Wire connected")
	else:
		print("Wire dropped")
