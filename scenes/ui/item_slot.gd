extends VBoxContainer

@export var item_id: String = ""          
@export var icon_texture: Texture2D       

@onready var icon: TextureRect = $Icon
@onready var count_label: Label = $CountLabel

func _ready() -> void:
	# Set the icon
	icon.texture = icon_texture

	# Listen for inventory changes
	Inventory.changed.connect(update_slot)

	# Initial value
	update_slot()

func update_slot() -> void:
	var count := Inventory.get_count(item_id)
	count_label.text = str(count)
