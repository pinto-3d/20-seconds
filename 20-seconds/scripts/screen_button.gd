extends ScreenItem
class_name ScreenButton

@export var startFocused: bool = false

func _ready() -> void:
	super._ready()
	connect("pressed", _pressed)
	if startFocused:
		grab_focus()

func _process(delta: float) -> void:
	super._process(delta)

func _pressed() -> void:
	pass
