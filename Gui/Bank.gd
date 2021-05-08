extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var money:= 100
export (int) var money_per_topup := 5
export (float) var time_between_topups := 5.0

var topup_timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Text/MoneyLabel.text = str(money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if topup_timer < time_between_topups:
		topup_timer += delta
	else:
		change_money(money_per_topup)
		topup_timer -= time_between_topups

func change_money(amount: int) -> void:
	money += amount
	$Text/MoneyLabel.text = str(money)


func pay(amount: int) -> bool:
	if money >= amount:
		change_money(-amount)
		return true
	else:
		return false
