extends BoxContainer
class_name ButtonHintFamily

enum Direction {
	Horizontal,
	Vertical
}

var btnHintScene: PackedScene = load("res://scenes/button_hint.tscn")
var orScene: PackedScene = load("res://scenes/or.tscn")
@export var actionName: String = ""
@export var direction:  Direction = Direction.Vertical

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.controllerChanged.connect(_controller_changed)
	set_button_hints()
	pass # Replace with function body.

func set_button_hints():
	var actions = InputMap.action_get_events(actionName)
	var isFirst = true
	for action in actions:
		if not isFirst:
			#var orl = await G.spawn(orScene)
			#orl.reparent(self)
			pass
		else:
			isFirst = false
			
		if action is InputEventKey:
			if G.controllerType == G.ControllerType.PC:
				var btnHint: ButtonHint = await G.spawn(btnHintScene)
				btnHint.reparent(self)
				btnHint.set_action_obj(action)
		elif action is InputEventJoypadButton:
			if G.controllerType != G.ControllerType.PC:
				var btnHint: ButtonHint = await G.spawn(btnHintScene)
				btnHint.reparent(self)
				btnHint.set_action_obj(action)

func _controller_changed(controllerType: G.ControllerType):
	set_button_hints()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
