extends StaticBody2D

@onready var interactable: InteractableComponent = $InteractableComponent

@export var carrot_item: InventoryItem
@export var wheat_item: InventoryItem
@export var tomato_item: InventoryItem
@export var log_item: InventoryItem
@export var sell_interval: float = 0.1 # seconds between each item sold

var is_selling = false
var seller: Player = null

func _ready():
	$AnimatedSprite2D.play()
	interactable.interactable_activated.connect(_on_interactable_component_body_entered)
	interactable.interactable_deactivated.connect(_on_interactable_component_body_exited)


func _on_interactable_component_body_entered(body):
	if not (body is Player):
		return
	
	var player := body as Player
	if player.inv == null:
		push_error("SellZone: player.inv is not assigned.")
		return
		
	var inv := player.inv
	
	var carrots_sold := 0
	var wheat_sold := 0
	var tomatoes_sold := 0
	var logs_sold := 0
	
	# Removing crops from inventory 
	for slot in inv.slots:
		if slot.item == null:
			continue
		
		if slot.item == carrot_item:
			carrots_sold += slot.amount
			slot.item = null
			slot.amount = 0
		elif slot.item == wheat_item:
			wheat_sold += slot.amount
			slot.item = null
			slot.amount = 0
		elif slot.item == tomato_item:
			tomatoes_sold += slot.amount
			slot.item = null
			slot.amount = 0
		elif slot.item == log_item:
			logs_sold += slot.amount
			slot.item = null
			slot.amount = 0
			
	
	# Turn crops into coins
	# logs = 1 coin, carrots = 2 coin, wheat = 4 coins, tomatoes = 6 coins
	var coins_gained := logs_sold + carrots_sold * 2 + wheat_sold * 4 + tomatoes_sold * 6
	Global.coins += coins_gained
	
	inv.update.emit()
		

func _on_interactable_component_body_exited(body):
	if body == seller:
		is_selling = false
		seller = null

func _sell_crops_slowly(player: Player):
	if player.inv == null:
		push_error("SellZone: Player.inv is not assigned.")
		is_selling = false
		return
		
	var inv := player.inv
	
	while is_selling:
		var sold_any_this_pass := false
		
		for slot in inv.slots:
			if not is_selling:
				return
			
			if slot.item == null or slot.amount <= 0:
				continue
				
			var coins_for_this_item := 0
			
			if slot.item == carrot_item:
				coins_for_this_item = 1
			elif slot.item == wheat_item:
				coins_for_this_item = 2
			elif slot.item == tomato_item:
				coins_for_this_item = 3
			else:
				continue
				
			# sell one item
			slot.amount -= 1
			if slot.amount <= 0:
				slot.amount = 0
				slot.item = null
				
			Global.coins += coins_for_this_item
			inv.update.emit()
			
			sold_any_this_pass = true
			await get_tree().create_timer(sell_interval).timeout
			
			# Nothin to sell this pass
			if not sold_any_this_pass:
				is_selling = false
				seller = null
				break
