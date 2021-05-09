extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export (float) var movement_speed = 300
export (float) var movement_distance = 900

var start_point : float
var movement_direction : float = -1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement = $Path2D/MovingPoint
	var new_offset = movement.offset
	
	var movement_step = movement_direction * movement_speed * delta
	
	new_offset += movement_step
	
	var distance_from_start = abs(start_point - new_offset)
	
	if distance_from_start > movement_distance:
		movement_direction *= -1.0
		new_offset += movement_direction * (distance_from_start - movement_distance)
	
	movement.offset = new_offset


func initialize(tower_position, path_position, path:Curve2D = null):
	position = tower_position
	$Path2D.curve = path
	start_point = path.get_closest_offset(path_position)
	$Path2D/MovingPoint.offset = start_point


func _on_Collision_area_shape_entered(area_id: int, area: Area2D, area_shape: int, local_shape: int) -> void:
	var enemy = get_node(area.get_path()).owner
	enemy.add_effect(SlowEffect.new(enemy, 5, 0.5))
	#.set("speed_modifier", 2)


func _on_Nerts_area_entered(area: Area2D) -> void:
	var enemy = area.owner
