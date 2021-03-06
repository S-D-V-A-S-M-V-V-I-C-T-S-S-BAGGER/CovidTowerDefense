extends AspectRatioContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (Texture) var default_texture
export (String) var default_name = "Tower Preview"
export (String) var default_description = ""

export (Texture) var bat_tower_texture
export (String) var bat_tower_name
export (String) var bat_tower_description

export (Texture) var trump_tower_texture
export (String) var trump_tower_name
export (String) var trump_tower_description

export (Texture) var cell_tower_texture
export (String) var cell_tower_name
export (String) var cell_tower_description

export (Texture) var fastfood_tower_texture
export (String) var fastfood_tower_name
export (String) var fastfood_tower_description

export (Texture) var lidl_tower_texture
export (String) var lidl_tower_name
export (String) var lidl_tower_description

export (Texture) var nerts_tower_texture
export (String) var nerts_tower_name
export (String) var nerts_tower_description

export (Texture) var internet_tower_texture
export (String) var internet_tower_name
export (String) var internet_tower_description

export (Texture) var nose_tower_texture
export (String) var nose_tower_name
export (String) var nose_tower_description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_preview(default_texture, default_name, default_description)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func update_preview(texture: Texture, name: String, description: String) -> void:
	$VBoxContainer/CenterContainer/TextureRect.texture = texture
	$VBoxContainer/TowerName.text = name
	$VBoxContainer/TowerDescription.text = description


func _on_BatTower_mouse_entered() -> void:
	update_preview(bat_tower_texture, bat_tower_name, bat_tower_description)


func _on_Trump_mouse_entered() -> void:
	update_preview(trump_tower_texture, trump_tower_name, trump_tower_description)


func _on_CellTower_mouse_entered() -> void:
	update_preview(cell_tower_texture, cell_tower_name, cell_tower_description)


func _on_FastfoodTower_mouse_entered() -> void:
	update_preview(fastfood_tower_texture, fastfood_tower_name, fastfood_tower_description)


func _on_LidlTower_mouse_entered() -> void:
	update_preview(lidl_tower_texture, lidl_tower_name, lidl_tower_description)


func _on_NertsTower_mouse_entered() -> void:
	update_preview(nerts_tower_texture, nerts_tower_name, nerts_tower_description)
	
func _on_InternetTower_mouse_entered() -> void:
	update_preview(internet_tower_texture, internet_tower_name, internet_tower_description)
	
func _on_Nose_mouse_entered() -> void:
	update_preview(nose_tower_texture, nose_tower_name, nose_tower_description)
	
