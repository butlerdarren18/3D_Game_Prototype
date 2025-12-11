extends CharacterBody3D

@export var animation_player : PlayerAnimationPlayer
@export var is_test_mode : bool = true

var is_sprinting = false

var speed = 5.0
const JUMP_VELOCITY = 4.5


signal movement_state_changed(state_name : String)

func _ready(): 
	if not is_test_mode: $TestCam.queue_free()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("movement_key_left", "movement_key_right", "movement_key_up", "movement_key_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	

	move_and_slide()
