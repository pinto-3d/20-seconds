extends CanvasLayer
class_name TouchControls

var target: Player

var up: Button
var down: Button
var left: Button
var right: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#up = $Control/movement/updown/up/Button
	#down = $Control/movement/updown/down/Button
	#left = $Control/movement/left/Button
	#right = $Control/movement/right/Button
	#up.button_down.connect(_up)
	#down.button_down.connect(_down)
	#left.button_down.connect(_left)
	#right.button_down.connect(_right)
	#
	#up.button_up.connect(_up_up)
	#down.button_up.connect(_down_up)
	#left.button_up.connect(_left_up)
	#right.button_up.connect(_right_up)
	#
	#$Control/buttons/crouch/Button.button_down.connect(_crouch)
	#$Control/buttons/crouch/Button.button_up.connect(_crouch_up)
	#
	#$Control/buttons/jump/Button.button_down.connect(_jump)
	#$Control/buttons/jump/Button.button_up.connect(_jump_up)
	#
	#$Control/buttons/shoot/Button.button_down.connect(_shoot)
	#$Control/buttons/shoot/Button.button_up.connect(_shoot_up)\
	
	
	$Control/pause/Button.pressed.connect(_pause)
	#set_touch_size(self)


func set_touch_size(node: Node):
	for child in node.get_children():
		if child is TouchScreenButton:
			child.position = child.get_parent().size/2
			child.scale = child.get_parent().size/2
		set_touch_size(child)

func _pause():
	Input.action_press("pause")
	await get_tree().process_frame
	Input.action_release("pause")

func _shoot():
	Input.action_press("shoot")
func _shoot_up():
	Input.action_release("shoot")

func _crouch():
	Input.action_press("crouch")
func _crouch_up():
	Input.action_release("crouch")

func _jump():
	Input.action_press("jump")
func _jump_up():
	Input.action_release("jump")

func _up():
	Input.action_press("up")
func _down():
	Input.action_press("down")
func _left():
	Input.action_press("left")
func _right():
	Input.action_press("right")

func _up_up():
	Input.action_release("up")
func _down_up():
	Input.action_release("down")
func _left_up():
	Input.action_release("left")
func _right_up():
	Input.action_release("right")

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if not target:
		if get_tree().get_node_count_in_group("player") > 0:
			target = get_tree().get_nodes_in_group("player")[0]
		else:
			return
	
	if target.state == Player.State.FREE:
		visible = true
	else:
		visible = false
