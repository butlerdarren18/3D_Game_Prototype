extends Sprite3D
class_name InputPrompt
@export var key : String 
func _init() -> void: 
	billboard = BaseMaterial3D.BILLBOARD_ENABLED

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(key): hide()
