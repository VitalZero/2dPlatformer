extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = str("x ", coins)

func add_coin_count():
	coins += 1

func _on_coin_collected():
	add_coin_count()
	_ready()
