extends Node2D

@export var item: InventoryItem
@onready var collectible: CollectibleComponent = $CollectibleComponent

func _ready():
	collectible.item = item
