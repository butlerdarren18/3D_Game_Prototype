extends InteractableEntity
class_name Mailbox
@export var letters : Array[Letter]
@onready var display: LetterDisplay = $LetterDisplay

var player_is_standing_near : bool = false 

func _ready(): 
	EventBus.UI_CLOSE_REQUESTED.connect(close)

func close():
	display.hide()
	if letters:
		EventBus.ITEM_DROPPED.emit(letters[0])
		letters.remove_at(0)
	
	
func open(): 
	display.set_text(letters[0].text)
	display.show()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact_key") and display.visible: close()
	if !letters: return 

	if Input.is_action_just_pressed("interact_key"): 
		open()


func _on_interact_area_body_entered(body: Node3D) -> void:
	if body is Player and letters: 
		input_prompt.show()
		player_is_standing_near = true 


func _on_interact_area_body_exited(body: Node3D) -> void: 
	if body is Player: 
		input_prompt.hide()
		player_is_standing_near = false 
