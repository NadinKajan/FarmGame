class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var inv: InventoryItem

var player_direction: Vector2
