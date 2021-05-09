extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var time_to_live

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Particles2D.set_one_shot(true)
	$Particles2D.set_emitting(true)
	time_to_live = $Particles2D.lifetime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_to_live -= delta
	if time_to_live <= 0:
		queue_free()
