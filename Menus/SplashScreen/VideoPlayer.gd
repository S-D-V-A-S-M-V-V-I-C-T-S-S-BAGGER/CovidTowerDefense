extends VideoPlayer

export (PackedScene) var next_scene
export (Array) var video_streams
var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_playing():
		return

	if current_index >= len(self.video_streams):
		get_tree().change_scene_to(next_scene)
		return
		
	self.stop()
	var new_stream = self.video_streams[current_index]
	self.set_stream(new_stream)
	self.play()

	current_index += 1
