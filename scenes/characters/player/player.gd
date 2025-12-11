class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var inv: Inv

var player_direction: Vector2

func collect(item: InventoryItem) -> void:
	if item == null:
		return
		
	if inv == null:
		push_error("Player.inv not assigned!")
		return
		
	inv.insert(item)
