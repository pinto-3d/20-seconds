extends CanvasLayer
class_name Screen

const DELAY_BT_ITEMS: float = 0.04


var curDelay: float = 0

#var items: Array[ScreenItem] = []

func _ready() -> void:
	find_descendant_nodes(self)

func find_descendant_nodes(node: Node):
	for child in node.get_children():
		if child is ScreenItem:
			add_item_to_delay(child)
		find_descendant_nodes(child)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func add_item_to_delay(item: ScreenItem):
	item.set_introing_delay(curDelay)
	curDelay += DELAY_BT_ITEMS
	#items.append(item)
