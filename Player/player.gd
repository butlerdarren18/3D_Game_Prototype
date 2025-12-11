extends CharacterBody3D
class_name Player 
@onready var movement_keys : Dictionary = preload("res://Resources/DictionaryResource/movement_key_collection.tres").collection
@onready var model = $godot_plush_model
@onready var camera = $"../Camera3D"
@onready var camera_distance = global_position - camera.global_position
var is_sprinting = false
var last_angle 
var regular_speed = 5.25
const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	
	# MOVE CAM WITH PLAYER 
	camera.global_position.x = global_position.x 
	camera.global_position.z = global_position.z - camera_distance.z
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector(movement_keys["right"], movement_keys["left"], movement_keys["down"], movement_keys["up"])
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var new_angle : float 
	
	# ROTATING THE PLAYER
	new_angle = model.rotation_degrees.y 
	var rotation_weight : float = 1
	
	if Input.is_action_pressed(movement_keys["left"]):
		new_angle = 90
	elif Input.is_action_pressed(movement_keys["right"]): 
		new_angle = -90
	elif Input.is_action_pressed(movement_keys["down"]): 
		if last_angle < 0: new_angle = -180 
		else: new_angle = 180 
		rotation_weight = 0.1
	elif Input.is_action_pressed(movement_keys["up"]):
		new_angle = 0 
		rotation_weight = 0.1
	
	if is_sprinting: rotation_weight *= 2
	for child in get_children(): 
		if child is not Camera3D:
			if child.rotation_degrees.y != new_angle:
				child.rotation_degrees.y = lerpf(child.rotation_degrees.y, new_angle, .05)

	last_angle = new_angle 
	var speed = regular_speed 
	if Input.is_action_pressed("sprint_key"): speed = regular_speed * 2
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		

	move_and_slide()
