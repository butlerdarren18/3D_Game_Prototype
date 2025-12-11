extends Node3D
class_name InteractableEntity
@export var interact_area : Area3D
@export var input_prompt : InputPrompt
@export var input_prompt_enabled : bool = true 
var interactable : bool = false 

func _ready(): 
	input_prompt.hide()
	interact_area.body_exited.connect(_on_interact_area_exited)
	interact_area.body_entered.connect(_on_interact_area_entered)


func _on_interact_area_entered(body): 
	if body is Player: 
		if input_prompt_enabled: input_prompt.show()
		interactable = true 
func _on_interact_area_exited(body): 
	if body is Player: 
		if input_prompt_enabled: input_prompt.hide()
		interactable = false 
