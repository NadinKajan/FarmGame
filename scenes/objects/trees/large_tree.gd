extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")
@export var item: InventoryItem
var player = null

func _ready() -> void:
	
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	
func on_max_damage_reached() -> void:
	call_deferred("add_log_scene")
	queue_free()
	
func add_log_scene() -> void:
	for i in range(2): # Large Tree drops 2 logs
		var log_instance = log_scene.instantiate() as Node2D
		log_instance.global_position = global_position
		
		var collectible := log_instance.get_node("CollectibleComponent") as CollectibleComponent
		if collectible:
			collectible.item = item
			collectible.collectible_name = item.name
			
		get_parent().add_child(log_instance)
		
