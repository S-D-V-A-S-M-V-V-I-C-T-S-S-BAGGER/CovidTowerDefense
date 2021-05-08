extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var active_position : Node = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func select_position(new_position : Node) -> void:
	if active_position:
		active_position.unpress()
	active_position = new_position

func deselect_position() -> void:
	active_position = null
