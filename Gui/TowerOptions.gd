extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var bat_tower
export (PackedScene) var slow_tower


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func place_tower(tower_scene:PackedScene) -> void:
	var selected_position = owner.get_node("TowerPositions").consume_position()
	if selected_position:
		var tower = tower_scene.instance()
		var tower_position = selected_position.position
		var path_position = selected_position.get_node("PathPosition").position
		tower.initialize(tower_position, path_position)
		owner.owner.add_child(tower)
		selected_position.disable()


func _on_BatTower_pressed():
	place_tower(bat_tower)


func _on_SlowTower_pressed():
	place_tower(slow_tower)
