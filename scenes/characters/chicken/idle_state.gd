extends NodeState

@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var idleTimeInterval: float = 5.0

@onready var idleTimer: Timer = Timer.new()

var idleStateTimeout: bool = false

func _ready() -> void:
	idleTimer.wait_time = idleTimeInterval
	idleTimer.timeout.connect(on_idle_state_timeout)
	add_child(idleTimer)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if idleStateTimeout:
		transition.emit("walk")


func _on_enter() -> void:
	sprite.play("idle")
	
	idleStateTimeout = false
	idleTimer.start()


func _on_exit() -> void:
	sprite.stop()
	idleTimer.stop()

func on_idle_state_timeout() -> void:
	idleStateTimeout = true
