extends Node2D
class_name Enemy


# Declare member variables here. Examples:
export(int) var speed = 300.0

export(NodePath) var path

var velocity := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Path").curve = get_node(path).curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_node("Path/PathFollower").offset += speed * delta
