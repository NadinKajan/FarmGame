extends StaticBody2D

var plant = 0
var plantGrowing = false
var plantDone = false

func _ready() -> void:
	plantGrowing = false
	plantDone = false
	$Plant.frame = 0
	$Plant.play("none")

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
		
