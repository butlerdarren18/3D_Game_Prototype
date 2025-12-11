extends Control

func _ready() -> void:
	EventBus.UI_CLOSE_REQUESTED.connect(close)

func close(): 
	hide()
