extends Node

export (Array) var enemy_names
var current_index = 0

func show(index: int):
	self.visible = true
	# Pause the game.
	get_tree().paused = true
	
	current_index = index
	self.show_video(current_index)
	
	
func show_video(index: int):
	var enemy_name = self.enemy_names[current_index]
	var video = VideoStreamWebm.new()
	video.set_file("res://videos/Enemies/" + enemy_name + ".webm")
	$TextureRect.visible = false
	$VideoPlayer.set_stream(video)
	$VideoPlayer.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VideoPlayer_finished():
	$VideoPlayer.stop()
	# Show the picture of this same enemy.
	var enemy_name = self.enemy_names[current_index]
	var texture = load("res://videos/Enemies/" + enemy_name + ".png")
	$TextureRect.texture = texture
	$TextureRect.visible = true


func _on_CloseButton_pressed():
	current_index = 0
	self.visible = false
	$VideoPlayer.stop()
	get_tree().paused = false
