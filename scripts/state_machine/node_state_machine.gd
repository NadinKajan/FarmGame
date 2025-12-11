class_name NodeStateMachine
extends Node

@export var initial_node_state: NodeState

var node_states: Dictionary[String, NodeState] = {}
var current_node_state: NodeState
var current_node_state_name: String = ""
var parent_node_name: String = ""


func _ready() -> void:
	parent_node_name = get_parent().name

	for child in get_children():
		if child is NodeState:
			var key := _get_state_key(child.name)
			node_states[key] = child
			child.transition.connect(transition_to)

	if initial_node_state:
		current_node_state = initial_node_state
		current_node_state_name = _get_state_key(current_node_state.name)
		current_node_state._on_enter()


func _process(delta: float) -> void:
	if current_node_state:
		current_node_state._on_process(delta)


func _physics_process(delta: float) -> void:
	if current_node_state:
		current_node_state._on_physics_process(delta)
		current_node_state._on_next_transitions()
		# print(parent_node_name, " Current State: ", current_node_state_name)


func transition_to(node_state_name: String) -> void:
	var key := _get_state_key(node_state_name)

	if current_node_state and key == current_node_state_name:
		return
		
	if Global.isDraggingSeed:
		return

	var new_node_state: NodeState = node_states.get(key)
	if new_node_state == null:
		return

	if current_node_state:
		current_node_state._on_exit()

	current_node_state = new_node_state
	current_node_state_name = key
	current_node_state._on_enter()
	# print("Current State: ", current_node_state_name)


func _get_state_key(name: String) -> String:
	return name.to_lower()
