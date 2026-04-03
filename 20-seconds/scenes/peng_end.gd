extends Control

var hand: TextureRect
var beak: TextureRect
var peng: TextureRect
var cheek: TextureRect

var handStartAngle: float = 0
var handEndAngle: float = 18.7

var state: State = State.Sitting

enum State {
	Sitting,
	TowardMouth,
	Chewing,
	LeavingMouth
}

var dictStateLerps = {
	State.Sitting: 1,
	State.TowardMouth: 40,
	State.Chewing: 1,
	State.LeavingMouth: 40
}
var dictStateWait = {
	State.Sitting: 5,
	State.TowardMouth: 0,
	State.Chewing: 1,
	State.LeavingMouth: 0
}

var LERP: float = 1
var MIN_DIST: float = 1
var limbsSet: int = 0
var timer: float = 0

var cheekRotMin = -40
var cheekRotMax = 8
var cheekDir = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand = $"Peng Hand"
	beak = $Peng2
	peng = $Peng
	cheek = $"Peng Cheek"
	cheek.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.Sitting:
			if timer > 0:
				timer -= delta
				if timer < 1:
					cheek.visible = false
					pass
			else:
				state = State.TowardMouth
				timer = dictStateWait[state]
			pass
		State.TowardMouth:
			cheek.visible = false
			if abs(hand.rotation_degrees - handEndAngle) > MIN_DIST:
				hand.rotation_degrees += -sign(hand.rotation_degrees - handEndAngle) * dictStateLerps[state] * delta
				pass
			else:
				state = State.Chewing
				timer = dictStateWait[state]
			pass
		State.Chewing:
			cheek.visible = true
			if abs(hand.rotation_degrees - (cheekRotMax if cheekDir > 0 else cheekRotMin)) > MIN_DIST:
				hand.rotation_degrees += cheekDir * dictStateLerps[state] * delta
			else:
				cheekDir *= -1
			if timer > 0:
				timer -= delta
			else:
				state = State.LeavingMouth
				timer = dictStateWait[state]
			pass
		State.LeavingMouth:
			if abs(hand.rotation_degrees - handStartAngle) > MIN_DIST:
				hand.rotation_degrees += -sign(hand.rotation_degrees - handStartAngle) * dictStateLerps[state] * delta
			else:
				state = State.Sitting
				timer = dictStateWait[state]
			pass
	pass
