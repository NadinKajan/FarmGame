extends VBoxContainer

@export var item_id: String = ""          
@export var icon_texture: Texture2D       

@onready var icon: TextureRect = $Icon
@onready var count_label: Label = $CountLabel

func _ready() -> void:
	
	icon.texture = icon_texture # set the icon
	Inventory.changed.connect(update_slot) # listen for inventory changes
	update_slot() # initial value

func update_slot() -> void:
	var count := Inventory.get_count(item_id)
	count_label.text = str(count)
