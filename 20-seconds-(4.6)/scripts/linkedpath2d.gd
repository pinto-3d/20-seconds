extends Line2D
class_name LinePath2D

var index: int = 0

func _ready() -> void:
	var line: LinePath2D
	pass

func _process(delta: float) -> void:
	
	pass

func closest_to_point(pos: Vector2):
	var closestInd: int = -1
	var closestDist: float = 10000
	for i in range(0, points.size()):
		var newDist = points[i].distance_to(pos)
		if closestDist > newDist:
			closestDist = newDist
			closestInd = i
	pass
