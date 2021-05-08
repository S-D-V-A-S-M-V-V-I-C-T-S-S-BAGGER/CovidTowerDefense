extends AudioStreamPlayer2D

var random = RandomNumberGenerator.new()

const tracks = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14',
	'15','16','17','18','19','20','21','22','23','24','25','26','27']

func _ready():
	sound_delay()

func play_random_sound():
	random.randomize()
	var rand_nb = random.randi_range(0, tracks.size() - 1)
	print(rand_nb)
	var audiostream = load('res://Sounds/cough-files/cough' + tracks[rand_nb] + '.mp3')
	
	set_stream(audiostream)
	play()


func sound_delay():
	random.randomize()
	# Setup
	var timer = Timer.new()
	timer.set_wait_time(random.randi_range(5, 10))
	self.add_child(timer)
	timer.start()

	# Continue when the timeout signal is send
	yield(timer, "timeout")
	print("some seconds later")

	# Clean up
	timer.queue_free()
	play_random_sound()
