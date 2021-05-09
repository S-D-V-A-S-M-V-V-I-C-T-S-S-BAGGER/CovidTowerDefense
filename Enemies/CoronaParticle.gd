extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (float) var duration = 10.0
export (float) var dps = 1.0
export (float) var infectiousness = 0.01

export (float) var time_to_live = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Particles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_to_live -= delta
	
	if time_to_live <= 0:
		$Collider/CollisionShape.disabled = true
		queue_free()


func _on_Collider_area_entered(area: Area2D) -> void:
	var enemy = area.owner
	enemy.add_effect(CoronaEffect.new(enemy, duration, dps, infectiousness))
