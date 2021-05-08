extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(int) var max_bat_count = 3
export(float) var time_between_bats = 3.0


export var bat_count := 1
export var bat_timer := 0.0


func initialize(tower_position, path_position):
	position = tower_position
	$Bat.position = path_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_bat_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bat_timer < time_between_bats:
		# Increase the timer
		bat_timer += delta
	else:
		if bat_count < max_bat_count:
			# Add a bat
			bat_count += 1
			set_bat_animation()
			
			bat_timer = 0.0


func set_bat_animation():
	match bat_count:
		0:
			$Bat/AnimatedSprite.play("zero")
		1:
			$Bat/AnimatedSprite.play("one")
		2:
			$Bat/AnimatedSprite.play("two")
		3:
			$Bat/AnimatedSprite.play("three")
		_:
			$Bat/AnimatedSprite.play("many")


func _on_Bat_area_entered(area: Area2D) -> void:
	if bat_count > 0:
		bat_count -= 1
		set_bat_animation()
		
		var enemy = get_node(area.get_path()).get_parent().get_parent().get_parent()
		enemy.damage(50)
