class_name CollectibleComponent
extends Area2D

@export var collectible_name: String
@export var item: InventoryItem

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.collect(item)
		get_parent().queue_free()
