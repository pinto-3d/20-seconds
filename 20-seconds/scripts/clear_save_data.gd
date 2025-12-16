extends ScreenButton

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	super._process(delta)

func _pressed() -> void:
	super._pressed()
	G.gameSave = Save.create_blank(G.levelPaths.size())
	Save.set_save(G.gameSave)
	_text = "Save Cleared!"
