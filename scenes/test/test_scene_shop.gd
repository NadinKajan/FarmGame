extends Node2D

func _physics_process(delta):
	$CoinDisplay/Control/CoinText.text = ("= " + str(Global.coins))
