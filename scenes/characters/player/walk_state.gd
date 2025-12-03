extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	# Only pick an animation if there's input
	if direction != Vector2.ZERO:
		# Decide which cardinal direction we are "facing"
		var facing := direction

		if abs(facing.x) > abs(facing.y):
			# More horizontal than vertical → face left/right
			facing = Vector2(sign(facing.x), 0)
		else:
			# More vertical than horizontal → face up/down
			facing = Vector2(0, sign(facing.y))

		# Save facing for Idle state
		player.player_direction = facing

		# Play animation based on facing
		if facing == Vector2.UP:
			animated_sprite_2d.play("walk_back")
		elif facing == Vector2.RIGHT:
			animated_sprite_2d.play("walk_right")
		elif facing == Vector2.DOWN:
			animated_sprite_2d.play("walk_front")
		elif facing == Vector2.LEFT:
			animated_sprite_2d.play("walk_left")
	else:
		# No input
		player.velocity = Vector2.ZERO

	# Actually move with the diagonal/smooth direction
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
