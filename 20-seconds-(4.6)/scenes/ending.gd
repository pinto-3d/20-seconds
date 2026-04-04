extends CanvasLayer
class_name Ending

var colorRect: ColorRect
var audio: AudioStreamPlayer
var pengAudio: AudioStreamPlayer

var ambience: AudioStream = preload("res://audio/ending/freesound_community-restaurant_ambence-53039.mp3")
var pengEat: AudioStream = preload("res://audio/ending/end peng chomp.mp3")

var inputTimer: float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorRect = $ColorRect
	audio = $AudioStreamPlayer
	audio.stream = ambience
	audio.play()
	pengAudio = $pengaudio
	pengAudio.stream = pengEat
	pengAudio.play()
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
