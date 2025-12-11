extends StaticBody2D

@onready var interactable: InteractableComponent = $InteractableComponent

func _ready():
	interactable.interactable_activated.connect(_on_area_2d_body_entered)
	interactable.interactable_deactivated.connect(_on_area_2d_body_exited)

func _on_area_2d_body_entered(body):
	if body is Player:
		print("Opened Shop!")
		
func _on_area_2d_body_exited(body):
	print("Leaving Shop!")
