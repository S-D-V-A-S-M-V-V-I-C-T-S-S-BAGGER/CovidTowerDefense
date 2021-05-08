extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func initialize(tower_position, path_position):
	position = tower_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_Collision_area_shape_entered(area_id: int, area: Area2D, area_shape: int, local_shape: int) -> void:
	get_node(area.get_path()).get_parent().get_parent().get_parent().set("speed_modifier", 1.5)
	
