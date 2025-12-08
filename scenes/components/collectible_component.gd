class_name CollectibleComponent
extends Area2D

@export var collectible_name: String



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Inventory.add_item(collectible_name, 1)
		print("Collected")
		get_parent().queue_free()
