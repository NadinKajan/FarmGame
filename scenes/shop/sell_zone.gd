extends StaticBody2D

@onready var interactable: InteractableComponent = $InteractableComponent

func _ready():
	$AnimatedSprite2D.play()
	interactable.interactable_activated.connect(_on_interactable_component_body_entered)


func _on_interactable_component_body_entered(body):
	if body is Player:
		# carrots = 1 coin, wheat = 2 coins, tomato = 3 coin
		var carrots = Global.numCarrots
		var wheat = Global.numWheat
		var tomatoes = Global.numTomatoes
		var coins = Global.coins
		
		coins += carrots 
		coins += wheat * 2
		coins += tomatoes * 3
		
		carrots = 0
		wheat = 0
		tomatoes = 0
		
		Global.coins = coins
		Global.numCarrots = carrots
		Global.numWheat = wheat
		Global.numTomatoes = tomatoes
		
