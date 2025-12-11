extends StaticBody2D

# item 1 = carrot, 2 = wheat, 3 = tomatoes, 4 = land
var item = 1

var carrotPrice = 1
var wheatPrice = 5
var tomatoPrice = 10

var landPriceFactor = 1.75
var landPurchased = 0
var landBaseCost = 2
var landCap = 18

var carrotOwned = false
var wheatOwned = false
var tomatoOwned = false
var price = 0

func _ready():
	$Icon.play("carrotSeed")
	item = 1
	
func _physics_process(delta):
	if self.visible == true:
		if item == 1:
			$Icon.play("carrotSeed")
			$PriceLabel.text = "1"
			if Global.coins >= carrotPrice:
				if not carrotOwned:
					$BuyButtonBackground.color = "353ad31a" # green
				else:
					$BuyButtonBackground.color = "35d31a1a" # red 
			else:
				$BuyButtonBackground.color = "35d31a1a" # red
					
		elif item == 2:
			$Icon.play("wheatSeed")
			$PriceLabel.text = "5"
			if Global.coins >= wheatPrice:
				if not wheatOwned:
					$BuyButtonBackground.color = "353ad31a" # green
				else:
					$BuyButtonBackground.color = "35d31a1a" # red 
			else:
				$BuyButtonBackground.color = "35d31a1a" # red
		elif item == 3:
			$Icon.play("tomatoSeed")
			$PriceLabel.text = "10"
			if Global.coins >= tomatoPrice:
				if not tomatoOwned:
					$BuyButtonBackground.color = "353ad31a" # green
				else:
					$BuyButtonBackground.color = "35d31a1a" # red 
			else:
				$BuyButtonBackground.color = "35d31a1a" # red
		elif item == 4:
			var current_land_price = get_land_price()
			$Icon.play("land")
			$PriceLabel.text = str(current_land_price)
			
			if Global.coins >= current_land_price and landPurchased < landCap:
				if landPurchased <= landCap:
					$BuyButtonBackground.color = "353ad31a" # green
				else:
					$BuyButtonBackground.color = "35d31a1a" # red 
			else:
				$BuyButtonBackground.color = "35d31a1a" # red

func _on_button_left_pressed():
	swap_item_back()

func _on_button_right_pressed():
	swap_item_forward()

func _on_buy_button_pressed():
	if item == 1:
		price = carrotPrice
		if Global.coins >= price:
			if not carrotOwned:
				buy()
	elif item == 2:
		price = wheatPrice
		if Global.coins >= price:
			if not wheatOwned:
				buy()
	elif item == 3:
		price = tomatoPrice
		if Global.coins >= price:
			if not tomatoOwned:
				buy()
	elif item == 4:
		price = get_land_price()
		if Global.coins >= price:
			if landPurchased <= landCap:
				buy()
			
func swap_item_back():
	# 1=carrot, 2=wheat, 3=tomatoes
	if item == 1:
		item = 4
	elif item == 4:
		item = 3
	elif item == 3:
		item = 2
	else:
		item = 1

func swap_item_forward():
	if item == 1:
		item = 2
	elif item == 2:
		item = 3
	elif item == 3:
		item = 4
	else:
		item = 1

func buy():
	Global.coins -= price
	if item == 1:
		carrotOwned = true
	elif item == 2:
		wheatOwned = true
	elif item == 3:
		tomatoOwned = true
	elif item == 4:
		landPurchased += 1
		var shop = get_parent()
		if shop and shop.has_method("unlock_land"):
			shop.unlock_land(landPurchased)

func get_land_price():
	return int(landBaseCost * pow(landPriceFactor, landPurchased))
