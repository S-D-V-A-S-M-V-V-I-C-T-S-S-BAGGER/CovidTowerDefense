extends Enemy
class_name Student


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var elder_scene : PackedScene = load("res://Enemies/Elder.tscn")

var parent_offset = 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func on_die():
	var elder1 : Enemy = elder_scene.instance()
	elder1.initialize($Path.curve, level)
	elder1.get_node("Path/MovingPoint").offset = $Path/MovingPoint.offset + parent_offset
	level.add_child(elder1)
	
	var elder2 : Enemy = elder_scene.instance()
	elder2.initialize($Path.curve, level)
	elder2.get_node("Path/MovingPoint").offset = $Path/MovingPoint.offset - parent_offset
	level.add_child(elder2)
	
