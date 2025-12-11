extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_display: Label = $CenterContainer/Panel/Label

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount_display.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_display.visible = true
		amount_display.text = str(slot.amount)
	
