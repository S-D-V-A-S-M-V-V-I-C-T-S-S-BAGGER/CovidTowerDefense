extends AudioStreamPlayer

var random = RandomNumberGenerator.new()

const tracks = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14',
	'15','16','17','18','19','20','21','22','23','24','25','26','27']


func play_random_sound():
	random.randomize()
	var rand_nb = random.randi_range(0, tracks.size() - 1)
	var audiostream = load('res://Sounds/cough-files/cough' + tracks[rand_nb] + '.mp3')
	
	set_stream(audiostream)
	play()
