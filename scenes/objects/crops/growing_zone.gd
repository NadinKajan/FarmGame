extends StaticBody2D

var plant = 0
var plantGrowing = false
var plantDone = false

@export var crop_collectible_scene: PackedScene
@export var carrot_item: InventoryItem
@export var wheat_item: InventoryItem
@export var tomato_item: InventoryItem

func _ready() -> void:
	reset_plot()

func _physics_process(delta):
	if !plantGrowing:
		plant = Global.plantSelected

func _on_area_2d_area_entered(area):
	if !plantGrowing:
		if plant == 1:
			plantGrowing = true
			$CarrotTimer.start()
			$Plant.play("carrotGrowing")
		if plant == 2:
			plantGrowing = true
			$WheatTimer.start()
			$Plant.play("wheatGrowing")
		if plant == 3:
			plantGrowing = true
			$TomatoTimer.start()
			$Plant.play("tomatoGrowing")
	else: #plant already growing here
		print("plant is already growing here!")
		
func _on_CarrotTimer_timeout():
	var carrot_plant = $Plant
	if carrot_plant.frame < 3:
		carrot_plant.frame += 1
		$CarrotTimer.start()
	else:
		plantDone = true
		
func _on_WheatTimer_timeout():
	var wheat_plant = $Plant
	if wheat_plant.frame < 3:
		wheat_plant.frame += 1
		$WheatTimer.start()
	else:
		plantDone = true
		
func _on_TomatoTimer_timeout():
	var tomato_plant = $Plant
	if tomato_plant.frame < 3:
		tomato_plant.frame += 1
		$TomatoTimer.start()
	elif tomato_plant.frame == 3:
		plantDone = true
		
		
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("hit") and not Global.isDraggingSeed:
		match plant:
			1:
				Global.numCarrots += 1
			2:
				Global.numWheat += 1
			3:
				Global.numTomatoes += 1
				
		reset_plot()
		
		print("Number of carrots: " + str(Global.numCarrots))
		print("Number of Wheat: " + str(Global.numWheat))
		print("Number of Tomatoes: " + str(Global.numTomatoes))
		
		
func reset_plot() -> void:
	plantGrowing = false
	plantDone = false
	plant = 0
	
	$Plant.stop()
	$Plant.animation = "none"
	$Plant.frame = 0
	
func _spawn_crop_collectible():
	if crop_collectible_scene == null:
		push_error("GrowingZone: crop scene not assigned.")
		return
	
	var collectible := crop_collectible_scene.instantiate() as Node2D
	collectible.global_position = global_position
	var item_to_give: InventoryItem = null
	
	match plant:
		1:
			item_to_give = carrot_item
		2:
			item_to_give = wheat_item
		3: 
			item_to_give = tomato_item
			
	if item_to_give == null:
		push_error("GrowingZone: item for plant " + str(plant) + " not assigned.")
	else:
		var cc := collectible.get_node_or_null("CollectibleComponent")
		if cc:
			cc.item = item_to_give
		
	get_parent().add_child(collectible)
