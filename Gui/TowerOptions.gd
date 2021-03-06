extends VBoxContainer

export (PackedScene) var bat_tower
export (int) var bat_tower_cost = 10
export (PackedScene) var slow_tower
export (int) var slow_tower_cost = 10
export (PackedScene) var cell_tower
export (int) var cell_tower_cost = 10
export (PackedScene) var fastfood_tower
export (int) var fastfood_tower_cost = 10
export (PackedScene) var lidl_tower
export (int) var lidl_tower_cost = 10
export (PackedScene) var nerts_tower
export (int) var nerts_tower_cost = 10
export (PackedScene) var internet_tower
export (int) var internet_tower_cost = 10
export (PackedScene) var nose_tower
export (int) var nose_tower_cost = 10

export (NodePath) var nerts_path

var hud : Hud

# Called when the node enters the scene tree for the first time.
func _ready():
	hud = owner


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func place_tower(tower_scene:PackedScene, cost:int, path = null) -> void:
	var bank = hud.level
	var position_selector = hud.get_node("TowerPositions")
	
	var selected_position = position_selector.active_position
	if selected_position and bank.pay(cost):
		position_selector.deselect_position()
		var tower = tower_scene.instance()
		var tower_position = selected_position.position
		var path_position = selected_position.get_node("PathPosition").position
		owner.owner.add_child(tower)
		if path:
			tower.initialize(tower_position, path_position, path)
		else:
			tower.initialize(tower_position, path_position)
		selected_position.disable()


func _on_BatTower_pressed():
	place_tower(bat_tower, bat_tower_cost)


func _on_SlowTower_pressed():
	place_tower(slow_tower, slow_tower_cost)


func _on_CellTower_pressed():
	place_tower(cell_tower, cell_tower_cost)


func _on_FastfoodTower_pressed():
	place_tower(fastfood_tower, fastfood_tower_cost)


func _on_LidlTower_pressed():
	place_tower(lidl_tower, lidl_tower_cost)


func _on_NertsTower_pressed():
	var path = get_node(nerts_path)
	place_tower(nerts_tower, nerts_tower_cost, path)


func _on_InternetTower_pressed():
	place_tower(internet_tower, internet_tower_cost)


func _on_Nose_pressed():
	place_tower(nose_tower, nose_tower_cost)
	pass # Replace with function body.
