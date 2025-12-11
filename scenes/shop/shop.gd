extends StaticBody2D

@onready var interactable: InteractableComponent = $InteractableComponent
@export var growingZones: Array[Node2D] = []

func _ready():
	interactable.interactable_activated.connect(_on_area_2d_body_entered)
	interactable.interactable_deactivated.connect(_on_area_2d_body_exited)
	$ShopMenu.visible = false
	
	#Hiding all growing zones
	for gz in growingZones:
		if gz:
			gz.visible = false
			if gz.has_method("reset_plot"):
				gz.reset_plot()

func _on_area_2d_body_entered(body):
	if body is Player:
		$ShopMenu.visible = true
		
func _on_area_2d_body_exited(body):
	$ShopMenu.visible = false

func _process(delta):
	$CarrotSeedpack.visible = $ShopMenu.carrotOwned
	$WheatSeedpack.visible  = $ShopMenu.wheatOwned
	$TomatoSeedpack.visible = $ShopMenu.tomatoOwned

func unlock_land(landCount : int) -> void:
	var index := landCount - 1  #landCount is 1-based
	print("Unlocking land index: ", index)
	if index >= 0 and index < growingZones.size():
		var zone := growingZones[index]
		if zone:
			print("Zone found: ", zone.name, " at path: ", zone.get_path())
			print("Setting unlocked to true")
			zone.visible = true
			zone.unlocked = true
			print("Zone unlocked value after setting: ", zone.unlocked)
		else:
			print("Zone is null!")
	else:
		print("index out of range!")
