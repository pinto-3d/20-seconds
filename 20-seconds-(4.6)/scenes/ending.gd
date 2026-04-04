extends CanvasLayer
class_name Ending

var colorRect: ColorRect

var inputTimer: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorRect = $ColorRect
	pass # Replace with function body.

signal ended()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if colorRect.color.a > 0:
		colorRect.color.a -= delta
	if inputTimer > 0:
		inputTimer -= delta
	else:
		if Input.is_action_just_pressed("advance_text") || Input.is_action_just_pressed("pause"):
			ended.emit()
			pass
	pass
