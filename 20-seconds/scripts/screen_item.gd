extends Control
class_name ScreenItem

var textDest: String = ""
const TIME_PER_CHAR: float = 0.02
var timer: float = 0

var introing: bool = false
var introingDelay: float = 0

var _text:String: 
	get: 
		return get("text") 
	set(value): 
		set("text", value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var properties: Array[Dictionary] = get_property_list()
	if _text:
		textDest = _text
		_text = " "
		introing = true
		timer = TIME_PER_CHAR

func set_introing_delay(delays: float):
	introingDelay = delays
	if _text and _text != " ":
		textDest = _text
		_text = " "
		introing = true
		timer = TIME_PER_CHAR

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if introing:
		if introingDelay > 0:
			introingDelay -= delta
			return
		if _text:
			if _text.length() < textDest.length() or textDest.length() == 1:
				if timer > 0:
					timer -= delta
				else:
					timer = TIME_PER_CHAR
					if _text == " ":
						_text = textDest[0]
						return
					if _text == textDest:
						introing = false
						return
					_text = _text + textDest[_text.length()]
