extends Control
class_name Level


# Declare member variables here. Examples:
var enemies_spawned : int = 0

var enemies_killed : int = 0

var enemies_arrived : int = 0

var spawner_done : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemies_alive = get_living_enemy_count()
	
	if spawner_done and enemies_alive == 0:
		show_end_screen()


func get_living_enemy_count() -> int:
	var enemies_alive = enemies_spawned - enemies_killed - enemies_arrived
	return enemies_alive


func calculate_score() -> int:
	var score = enemies_killed * 5 - enemies_arrived * 20
	return score


func show_end_screen() -> void:
	$CanvasLayer/EndScreen.visible = true
	$CanvasLayer/EndScreen/CenterContainer/VBoxContainer/HBoxContainer/FinalScoreValueLabel.text = str(calculate_score())
