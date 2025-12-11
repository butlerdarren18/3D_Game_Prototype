extends AnimationPlayer

## Changes animations for player. 
## Works using parent "movement_state_changed" signal. Parent signal should pass a string. [br]
## if no string is passed the engine might give an error. 
class_name PlayerAnimationPlayer

## Obvious usage. [br] If not setting check the switch_animations method is being called and has not been altered.
@export var idle_speed_scale : float = 0.8 
## Obvious usage. [br] If not setting check the switch_animations method is being called and has not been altered.
@export var run_speed_scale : float = 1
## Obvious usage. [br] If not setting check the switch_animations method is being called and has not been altered.
@export var walk_speed_scale : float = 1


## This was originally set up with the FOSS godot plush character. 
##Please feel free to change it in the future when you have your own model. [br][br]
## Current keys: "walk", "run", "idle" [br]
## Current subkeys: "speed_scale", "name"* [br][br]
## Note: "name" should be the name of the animation in the player, otherwise it won't work
var animations_dictionary : Dictionary[String, Dictionary] = {
	"walk": {"speed_scale" : walk_speed_scale,
			 "name"		   : "walk"},
	"run":  {"speed_scale" : run_speed_scale,
			  "name"	   : "run"},
	"idle": {"speed_scale" : idle_speed_scale,
			 "name"		   : "idle"}
}

func switch_animations(animation_name : String): pass
