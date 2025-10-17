extends CharacterBody3D

@export var terminal_a: Area3D
@export var terminal_b: Area3D
@export var speed := 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction := Vector3.ZERO

var carrying_wire := false
var wire_ref: SignalWire = null
var near_terminal_a := false
var near_terminal_b := false

func _ready():
	if terminal_a:
		terminal_a.body_entered.connect(_on_terminal_a_entered)
		terminal_a.body_exited.connect(_on_terminal_a_exited)
	if terminal_b:
		terminal_b.body_entered.connect(_on_terminal_b_entered)
		terminal_b.body_exited.connect(_on_terminal_b_exited)

func _physics_process(delta):
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("Up"): input_dir.z -= 1
	if Input.is_action_pressed("Down"): input_dir.z += 1
	if Input.is_action_pressed("Right"): input_dir.x += 1
	if Input.is_action_pressed("Left"): input_dir.x -= 1

	input_dir = input_dir.normalized()
	direction = (transform.basis * input_dir).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

	if carrying_wire and wire_ref:
		wire_ref.update_position(global_transform.origin)

func _process(_delta):
	# --- PICK UP ---
	if Input.is_action_just_pressed("Enter") and near_terminal_a and not carrying_wire:
		for w in get_tree().get_nodes_in_group("SignalWire"):
			var wire = w as SignalWire
			if wire and not wire.picked_up:
				wire_ref = wire
				wire_ref.pick_up(global_transform.origin)
				carrying_wire = true
				print("Player picked wire.")
				return

	# --- DROP ---
	if Input.is_action_just_pressed("Space"):
		if carrying_wire and wire_ref:
			wire_ref.drop(near_terminal_b)
			print("Player dropped wire.")
			carrying_wire = false
			wire_ref = null
		else:
			print("Tried to drop, but no wire is being carried.")

# --- TERMINAL DETECTION ---
func _on_terminal_a_entered(body):
	if body == self:
		near_terminal_a = true
		print("Entered Terminal A")

func _on_terminal_a_exited(body):
	if body == self:
		near_terminal_a = false
		print("Exited Terminal A")

func _on_terminal_b_entered(body):
	if body == self:
		near_terminal_b = true
		print("Entered Terminal B")

func _on_terminal_b_exited(body):
	if body == self:
		near_terminal_b = false
		print("Exited Terminal B")
