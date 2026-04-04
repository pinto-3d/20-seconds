extends Panel
class_name BossHealthBar

var value: int = 0
var progressBar: ProgressBar

var emitterScene: PackedScene = preload("res://scenes/target_health_emitter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progressBar = $"boss health"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_value(value: int):
	if value < self.value:
		emit(Vector2.RIGHT)
	self.value = value
	progressBar.value = self.value

func hit():
	set_value(self.value - 1)
	emit(Vector2.DOWN)
	pass

func emit(dir: Vector2):
	var emitter: GPUParticles2D = await G.spawn(emitterScene)
	emitter.reparent(self)
	emitter.position = position - Vector2((progressBar.max_value - self.value) * (size.x / progressBar.max_value), -size.y + progressBar.size.y/2)
