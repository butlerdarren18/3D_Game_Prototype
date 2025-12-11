extends InteractableEntity
class_name Mailbox
@export var letters : Array[Letter]


func _input(event: InputEvent) -> void:
	if $LetterDisplay.visible: if Input.is_action_just_pressed("interact_key"): $LetterDisplay.hide()
	if not interactable: return
	if letters.size() == 0: 
		input_prompt_enabled = false 
		return 
	if Input.is_action_just_pressed("interact_key"): 
		$LetterDisplay.set_text(letters[0].text)
		$LetterDisplay.show()
		letters.remove_at(0)
