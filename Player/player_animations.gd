extends AnimationPlayer
class_name PlayerAnimationPlayer
@export var movement_keys : DictionaryResource 
## Changes animations for player. 
## Works using parent "movement_state_changed" signal. Parent signal should pass a string. [br]
## if no string is passed the engine might give an error. 

## Obvious usage. [br] If not setting check the switch_animations method is being called and has not been altered.
@export var speed_scales : Dictionary = {
	"walk" : 1.5,
	"idle" : 1.2,
	"run" : 1.5
}

## This was originally set up with the FOSS godot plush character. 
##Please feel free to change it in the future when you have your own model. [br][br]
## Current keys: "walk", "run", "idle" [br]
## Current subkeys: "speed_scale", "name"* [br][br]
## Note: "name" should be the name of the animation in the player, otherwise it won't work



var animation : String = "idle"
var backwards 
func _input(event: InputEvent) -> void:
	var is_movement_key_pressed : bool = false
	var inputs = movement_keys.collection
	
	# So we know whether to play_in_reverse of not
	backwards = Input.is_action_pressed("movement_key_down")
	
	# Call walk and run if keys are pressed 
	for key in inputs: 
		if Input.is_action_pressed(inputs[key]): 
			is_movement_key_pressed = true 
			if Input.is_action_pressed("sprint_key"): run()
			else: walk()
	if is_movement_key_pressed == false: idle()

func set_animation(animation_name:String):
	if current_animation != animation_name: 
		speed_scale = speed_scales[animation_name]
		play(animation_name)

func walk(): set_animation("walk")
func run(): set_animation("run")
func idle(): set_animation("idle")
