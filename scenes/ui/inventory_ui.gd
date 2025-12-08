extends Control

@onready var log_label: Label = $HBoxContainer/LogLabel

func _ready() -> void:
	# Update whenever inventory changes
	Inventory.changed.connect(update_ui)
	update_ui()  # initial value

func update_ui() -> void:
	var count := Inventory.get_count("log")
	log_label.text = "Logs: %d" % count
