extends Node2D

func _physics_process(delta):
	$CoinText.text = ("= " + str(Global.coins))
