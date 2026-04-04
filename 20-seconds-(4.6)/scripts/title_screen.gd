extends Screen
class_name TitleScreen

var start: Button
var btnLevelSelect: Button
var lblBottomLeft: Label
var buttonParent: Control
var titleLabel: Control

var background: TextureRect
var backgroundIcey: TextureRect
var textlabel: Label
var colorRect: ColorRect

var PRE_ICE_TIME: float = 2
var ICE_TIME: float = 0
var WHITE_FADE_LERP: float = 1
var timer: float = 0
var phase: int = -1

var ICE_Y_FADE_IN_LERP: float = 0.25
var ICE_Y: float = -240
var ICE_Y_LERP: float = 100

signal startPressed
signal settingsPressed
signal levelSelectPressed(type: LevelSelect.Type)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	start = $"Control/Buttons/VBoxContainer/Start Button"
	start.button_up.connect(_start_pressed)
	var settings: Button = $"Control/Buttons/VBoxContainer/Settings Button"
	settings.button_up.connect(_settings_pressed)
	
	btnLevelSelect = $"Control/Buttons/VBoxContainer/Level Select Button"
	btnLevelSelect.button_up.connect(_level_select_pressed)
	
	titleLabel = $Control/Label
	buttonParent = $Control/Buttons
	titleLabel.visible = false
	buttonParent.visible = false
	
	lblBottomLeft = $Control/lblBottomLeft
	textlabel = $Control/MarginContainer/Label
	textlabel.visible = true
	
	background = $Control/Background
	backgroundIcey = $Control/BackgroundIcey
	backgroundIcey.self_modulate.a = 0
	colorRect = $Control/ColorRect
	colorRect.color.a = 0
	timer = PRE_ICE_TIME
	
	if not G.firstBoot:
		phase = 5
		colorRect.queue_free()
		background.visible = true
		backgroundIcey.visible = false
		titleLabel.visible = true
		buttonParent.visible = true
		backgroundIcey.position.y = ICE_Y
		start.grab_focus()
		pass


func _start_pressed():
	startPressed.emit()
func _settings_pressed():
	settingsPressed.emit()
func _level_select_pressed():
	levelSelectPressed.emit(LevelSelect.Type.FromTitle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	super._process(delta)
	if phase < 5:
		if Input.is_action_just_pressed("skip_text"):
			phase = 5
			colorRect.queue_free()
			background.visible = true
			backgroundIcey.visible = false
			titleLabel.visible = true
			buttonParent.visible = true
			backgroundIcey.position.y = ICE_Y
			start.grab_focus()
			G.firstBoot = false
			pass
	else:
		return
	
	if phase == -1:
		if timer > 0:
			timer -= delta
		else:
			phase = 0
		pass
	elif phase == 0:
		if backgroundIcey.self_modulate.a < 1:
			backgroundIcey.self_modulate.a += ICE_Y_FADE_IN_LERP * delta
			pass
		if backgroundIcey.position.y > ICE_Y:
			backgroundIcey.position.y -= delta * ICE_Y_LERP
			pass
		else:
			phase = 1
			timer = ICE_TIME
		if backgroundIcey.position.y < ICE_Y:
			backgroundIcey.position.y = ICE_Y
			pass
		pass
	elif phase == 1:
		if timer > 0:
			timer -= delta
		else:
			phase += 1
			colorRect.color.a = 1
			background.visible = true
			backgroundIcey.visible = false
			titleLabel.visible = true
			buttonParent.visible = true
			pass
		pass
	elif phase == 2:
		if colorRect.color.a > 0:
			colorRect.color.a -= WHITE_FADE_LERP * delta
			pass
		else:
			colorRect.queue_free()
			start.grab_focus()
			G.firstBoot = false
			phase += 1
			pass
	
	pass
