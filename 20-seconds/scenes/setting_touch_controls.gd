extends ScreenButton

const strON: String = "Turn On"
const strOFF: String = "Turn Off"

func _ready() -> void:
	if G.usingTouchControls:
		_text = strOFF
	else:
		_text = strON
	super._ready()

func _process(delta: float) -> void:
	super._process(delta)

func _pressed() -> void:
	super._pressed()
	G.usingTouchControls = not G.usingTouchControls
	if G.usingTouchControls:
		_text = strOFF
	else:
		_text = strON
