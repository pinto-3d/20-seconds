extends Control


var hands: TextureRect
var head: TextureRect

var headStart: Vector2 = Vector2(0, 0)
var headEnd: Vector2 = Vector2(7, 4)

var handsStart: Vector2 = Vector2(0, 0)
var handsEnd: Vector2 = Vector2(-3, -11)

var LERP: float = 1
var MIN_DIST: float = 1

var state: State = State.Sitting

enum State {
	Sitting,
	TowardMouth,
	Chewing,
	LeavingMouth
}

var dictStateLerps = {
	State.Sitting: 1,
	State.TowardMouth: 3,
	State.Chewing: 1,
	State.LeavingMouth: 3
}
var dictStateWait = {
	State.Sitting: 5,
	State.TowardMouth: 0,
	State.Chewing: 1,
	State.LeavingMouth: 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hands = $"Bear Hands"
	head = $"Bear Head"
	pass # Replace with function body.

var limbsSet: int = 0
var timer: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	limbsSet = 0
	match state:
		State.Sitting:
			if timer > 0:
				timer -= delta
			else:
				state = State.TowardMouth
				timer = dictStateWait[state]
			pass
		State.TowardMouth:
			if hands.global_position.distance_to(handsEnd) > MIN_DIST:
				hands.global_position = hands.global_position.lerp(handsEnd, dictStateLerps[state] * delta)
			else:
				limbsSet += 1
			if head.global_position.distance_to(headEnd) > MIN_DIST:
				head.global_position = head.global_position.lerp(headEnd, dictStateLerps[state] * delta)
			else:
				limbsSet += 1
				
			if limbsSet == 2:
				state = State.Chewing
				timer = dictStateWait[state]
				pass
			pass
		State.Chewing:
			if timer > 0:
				timer -= delta
			else:
				state = State.LeavingMouth
				timer = dictStateWait[state]
			pass
		State.LeavingMouth:
			if hands.global_position.distance_to(handsStart) > MIN_DIST:
				hands.global_position = hands.global_position.lerp(handsStart, dictStateLerps[state] * delta)
			else:
				limbsSet += 1
			if head.global_position.distance_to(headStart) > MIN_DIST:
				head.global_position = head.global_position.lerp(headStart, dictStateLerps[state] * delta)
			else:
				limbsSet += 1
				
			if limbsSet == 2:
				state = State.Sitting
				timer = dictStateWait[state]
				pass
			pass
	
	pass
