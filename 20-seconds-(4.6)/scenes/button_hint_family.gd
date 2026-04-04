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

var childHints: Array[Control] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.controllerChanged.connect(_controller_changed)
	set_button_hints()

func remove_all_buttons():
	for child in childHints:
		child.queue_free()
	childHints.clear()

func set_button_hints():
	remove_all_buttons()
	
	var actions = InputMap.action_get_events(actionName)
	
	for action in actions:
		if action is InputEventKey:
			if G.controllerType == G.ControllerType.PC:
				await add_button_hint(action)
		elif action is InputEventJoypadButton or action is InputEventJoypadMotion:
			if G.controllerType != G.ControllerType.PC:
				await add_button_hint(action)

func add_button_hint(action):
	if childHints.size() > 0:
		var orl = await G.spawn(orScene)
		orl.reparent(self)
		childHints.append(orl)
		pass
	var btnHint: ButtonHint = await G.spawn(btnHintScene)
	btnHint.reparent(self)
	btnHint.set_action_obj(action)
	childHints.append(btnHint)
	pass

func _controller_changed(controllerType: G.ControllerType):
	set_button_hints()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
