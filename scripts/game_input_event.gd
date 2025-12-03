class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	var x := 0.0
	var y := 0.0
	
	if Input.is_action_pressed("walk_left"):
		x -= 1
	if Input.is_action_pressed("walk_right"):
		x += 1
	if Input.is_action_pressed("walk_up"):
		y -= 1
	if Input.is_action_pressed("walk_down"):
		y += 1
	
	direction = Vector2(x,y)
	
	# Normalizing so diagonal isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		
	return direction
	
static func is_movement_input() -> bool:
	return direction != Vector2.ZERO
