extends TextureRect
class_name ButtonHint

var lblKey: Label
var lblContainer: CenterContainer
var texIcon: TextureRect


const _unpressedY: float = -2
const _pressedY: float = 3
const _pressedScaleY: float = 0.8

@export var actionName: String = ""
@export var actionIndex: int = 0

var idleyAnimate: bool = true
var animatedWhenPressed: bool = false
var idleTimer: float = 0
const IDLE_TIME_PER_FRAME: float = 1

var buttonType: ButtonType

enum ButtonType{
	Keyboard,
	Controller,
	Dpad,
	Trigger
}

func _ready() -> void:
	lblKey = $CenterContainer/Label
	lblContainer = $CenterContainer
	texIcon = $TextureRect
	#set_action(actionName)
	pass

func set_action(string:String):
	actionName = string
	lblKey.text = InputMap.action_get_events(actionName)[actionIndex].as_text_physical_keycode()
	match lblKey.text:
		"Up":
			lblKey.text = "↑"
			pass
		"Down":
			lblKey.text = "↓"
			pass
		"Left":
			lblKey.text = "←"
			pass
		"Right":
			lblKey.text = "→"
			pass
	await get_tree().process_frame
	position.x -= lblContainer.size.x/2
	size.x = lblContainer.size.x

func set_action_obj(action: InputEvent):
	if action is InputEventKey:
		buttonType = ButtonType.Keyboard
		texIcon.visible = false
		lblKey.visible = true
		lblKey.text = action.as_text_physical_keycode()
		texture = G.texKeyUnpressed
		match lblKey.text:
			"Up":
				lblKey.text = "↑"
				pass
			"Down":
				lblKey.text = "↓"
				pass
			"Left":
				lblKey.text = "˿"
				pass
			"Right":
				lblKey.text = "→"
				pass
		await get_tree().process_frame
		if lblContainer.size.x > size.x:
			size.x = lblContainer.size.x
			position.x -= lblContainer.size.x/4
		pass
	elif action is InputEventJoypadButton:
		texIcon.visible = true
		lblKey.visible = false
		buttonType = ButtonType.Controller
		texture = G.texNsXbButtonUp
		match(action.button_index):
			JoyButton.JOY_BUTTON_A:
				match(G.controllerType):
					G.ControllerType.PS:
						texIcon.texture = G.texPsButtonCross
						pass
					G.ControllerType.Xbox:
						texIcon.texture = G.texXbButtonA
						pass
					G.ControllerType.Nintendo:
						texIcon.texture = G.texNsButtonB
						pass
				pass
			JoyButton.JOY_BUTTON_B:
				match(G.controllerType):
					G.ControllerType.PS:
						texIcon.texture = G.texPsButtonCircle
						pass
					G.ControllerType.Xbox:
						texIcon.texture = G.texXbButtonB
						pass
					G.ControllerType.Nintendo:
						texIcon.texture = G.texNsButtonA
						pass
				pass
			JoyButton.JOY_BUTTON_X:
				match(G.controllerType):
					G.ControllerType.PS:
						texIcon.texture = G.texPsButtonSquare
						pass
					G.ControllerType.Xbox:
						texIcon.texture = G.texXbButtonX
						pass
					G.ControllerType.Nintendo:
						texIcon.texture = G.texNsButtonY
						pass
				pass
			JoyButton.JOY_BUTTON_Y:
				match(G.controllerType):
					G.ControllerType.PS:
						texIcon.texture = G.texPsButtonTriangle
						pass
					G.ControllerType.Xbox:
						texIcon.texture = G.texXbButtonY
						pass
					G.ControllerType.Nintendo:
						texIcon.texture = G.texNsButtonX
						pass
				pass
			JoyButton.JOY_BUTTON_DPAD_UP:
				texIcon.visible = false
				buttonType = ButtonType.Dpad
				texture = G.texDpadUp
				unpressedTex = G.texDpad
				pass
			JoyButton.JOY_BUTTON_DPAD_DOWN:
				texIcon.visible = false
				buttonType = ButtonType.Dpad
				texture = G.texDpadDown
				unpressedTex = G.texDpad
				pass
			JoyButton.JOY_BUTTON_DPAD_LEFT:
				texIcon.visible = false
				buttonType = ButtonType.Dpad
				texture = G.texDpadLeft
				unpressedTex = G.texDpad
				pass
			JoyButton.JOY_BUTTON_DPAD_RIGHT:
				texIcon.visible = false
				buttonType = ButtonType.Dpad
				texture = G.texDpadRight
				unpressedTex = G.texDpad
				pass
			JoyButton.JOY_BUTTON_BACK:
				texIcon.visible = false
				buttonType = ButtonType.Dpad
				texture = G.texButtonSelect
				unpressedTex = G.texButtonSelect
				pass
			pass
		pass
	elif action is InputEventJoypadMotion:
		texIcon.visible = false
		buttonType = ButtonType.Trigger
		texture = G.texTriggerR
		unpressedTex = G.texTriggerRdown
		pass
		match(action.axis):
			JoyAxis.JOY_AXIS_TRIGGER_RIGHT:
				pass
		pass
	pressedTex = texture
var unpressedTex: CompressedTexture2D
var pressedTex: CompressedTexture2D
func _process(delta: float) -> void:
	
	if animatedWhenPressed:
		if actionName != null and actionName != "":
			if InputMap.has_action(actionName):
				if Input.is_action_pressed(actionName):
					press()
					return
				else:
					unpress()
		
		pass
	if idleyAnimate:
		if idleTimer < IDLE_TIME_PER_FRAME:
			idleTimer += delta
		else:
			idleTimer = 0
			if get_is_pressed():
				unpress()
			else:
				press()
	
	pass

func get_is_pressed():
	return isPressed

func press():
	isPressed = true
	
	match buttonType:
		ButtonType.Keyboard:
			texture = G.texKeyPressed
			lblContainer.position.y = _pressedY
			lblContainer.scale.y = _pressedScaleY
			pass
		ButtonType.Controller:
			texture = G.texNsXbButtonDown
			texIcon.position.y = _pressedY
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		ButtonType.Dpad:
			texture = pressedTex
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		ButtonType.Trigger:
			texture = pressedTex
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		pass

var isPressed: bool = false
	
func unpress():
	isPressed = false
	match buttonType:
		ButtonType.Keyboard:
			texture = G.texKeyUnpressed
			lblContainer.position.y = _unpressedY
			lblContainer.scale.y = 1
			pass
		ButtonType.Controller:
			texture = G.texNsXbButtonUp
			texIcon.position.y = 0
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		ButtonType.Dpad:
			texture = unpressedTex
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		ButtonType.Trigger:
			texture = unpressedTex
			lblContainer.position.y = 0
			lblContainer.scale.y = 1
			pass
		pass
