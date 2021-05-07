extends Node2D
class_name Enemy


# Declare member variables here. Examples:
export(int) var base_speed = 300.0

var speed_modifier := 1.0

export(NodePath) var path

var velocity := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Path").curve = get_node(path).curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = base_speed * speed_modifier
	get_node("Path/MovingPoint").offset += speed * delta
