extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (float) var duration = 10.0
export (float) var dps = 1.0
export (float) var infectiousness = 0.01


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Particles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Collider_area_entered(area: Area2D) -> void:
	var enemy = area.owner
	enemy.add_effect(CoronaEffect.new(enemy, duration, dps, infectiousness))
