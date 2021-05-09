extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export (float) var movement_speed = 300
export (float) var movement_distance = 60
export (float) var rotation_speed = 32

export (float) var respawn_time = 3.0

var start_point : float
var movement_direction : float = -1.0

var minimum_movement
var maximum_movement

var nerts_active = true
var respawn_timer = 0.0

export (float) var corona_duration = 10.0
export (float) var corona_dps = 1.0
export (float) var corona_infectiousness = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !nerts_active and respawn_timer <= 0:
		respawn_nerts()
	else:
		respawn_timer -= delta
	
	if nerts_active:
		var movement = $Path2D/MovingPoint
		var new_offset = movement.offset
		
		var movement_step = movement_direction * movement_speed * delta
		
		new_offset += movement_step
		
		if new_offset >= maximum_movement:
			var difference = new_offset - maximum_movement
			new_offset -= difference
			movement_direction *= -1
		elif new_offset <= minimum_movement:
			var difference = minimum_movement - new_offset
			new_offset += difference
			movement_direction *= -1
		
		movement.offset = new_offset
		
		$Path2D/MovingPoint/Sprite.rotation += movement_direction * rotation_speed * delta
		
func respawn_nerts():
	var movement = $Path2D/MovingPoint
	movement.offset = start_point
	$Path2D/MovingPoint/Nerts/Collision.disabled = false
	$Path2D/MovingPoint/Sprite.visible = true
	nerts_active = true

func despawn_nerts():
	respawn_timer = respawn_time
	$Path2D/MovingPoint/Nerts/Collision.disabled = true
	$Path2D/MovingPoint/Sprite.visible = false
	nerts_active = false

func initialize(tower_position, path_position, path:Path2D = null):
	position = tower_position
	$NertsSpawnPoint.position = path_position
	
	$Path2D.curve = path.curve
	$Path2D.global_position = path.global_position
	start_point = path.curve.get_closest_offset($NertsSpawnPoint.global_position)
	$Path2D/MovingPoint.offset = start_point
	
	minimum_movement = max(0, start_point - movement_distance)
	var path_length = path.curve.get_baked_length()
	maximum_movement = min(path_length-1, start_point + movement_distance)


func _on_Nerts_area_entered(area: Area2D) -> void:
	var enemy = area.owner
	enemy.add_effect(CoronaEffect.new(enemy, corona_duration, corona_dps, corona_infectiousness))
	despawn_nerts()
