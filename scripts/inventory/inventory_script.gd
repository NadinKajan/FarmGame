extends Node

signal changed

var items: Dictionary = {}

func add_item(id: String, amount: int = 1) -> void:
	if id in items:
		items[id] += amount
	else:
		items[id] = amount
	changed.emit()

func remove_item(id: String, amount: int = 1) -> void:
	if not id in items:
		return
	items[id] -= amount
	if items[id] <= 0:
		items.erase(id)
	changed.emit()

func get_count(id: String) -> int:
	return items.get(id, 0)

func has_item(id: String, amount: int = 1) -> bool:
	return get_count(id) >= amount
