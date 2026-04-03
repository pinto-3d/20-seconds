extends ScreenButton
class_name LevelButton

var lblTime: Label
var levelIndex: int = -1 

signal sbtn_pressed(index: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	lblTime = $Time
	lblTime.text = ""
	var pressed = get("pressed")
	pressed.connect(btn_pressed)

func _process(delta: float) -> void:
	super._process(delta)

func initialize(index: int, time: float):
	set("text", str(index))
	levelIndex = index
	if time != 20:
		lblTime.text = str(floor(100*(20-time))/100)

func btn_pressed():
	sbtn_pressed.emit(levelIndex)
