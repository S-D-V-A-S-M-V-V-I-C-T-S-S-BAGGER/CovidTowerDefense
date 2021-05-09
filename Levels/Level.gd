extends Control
class_name Level

export (int) var starting_money:= 100
export (int) var money_per_topup := 5
export (float) var time_between_topups := 5.0

var money : int
var topup_timer := 0.0

# Declare member variables here. Examples:
var enemies_spawned : int = 0
var enemies_killed : int = 0
var enemies_arrived : int = 0

var spawner_done : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# To show a new enemy: 
	$CanvasLayer/NewEnemy.show(0)
	money = starting_money


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check for end of game
	var enemies_alive = get_living_enemy_count()
	if spawner_done and enemies_alive == 0:
		show_end_screen()
	
	# Manage money
	topup_timer -= delta
	
	if topup_timer <= 0:
		money += money_per_topup
		topup_timer += time_between_topups


func pay(amount: int) -> bool:
	if amount <= money:
		money -= amount
		return true
	else:
		return false


func get_living_enemy_count() -> int:
	var enemies_alive = enemies_spawned - enemies_killed - enemies_arrived
	return enemies_alive


func calculate_score() -> int:
	var score = enemies_killed * 5 - enemies_arrived * 20
	return score


func show_end_screen() -> void:
	$CanvasLayer/EndScreen.visible = true
	$CanvasLayer/EndScreen/CenterContainer/VBoxContainer/HBoxContainer/FinalScoreValueLabel.text = str(calculate_score())


func _on_MenuButton_pressed() -> void:
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
