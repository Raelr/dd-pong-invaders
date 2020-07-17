extends Sprite

var elapsed : float = 0.0
var ttl : float = 0.0
var update : bool = false

func start(type : int, duration : float):
	ttl = duration
	update = true

func _process(delta):
	if update:
		elapsed += delta
		if elapsed >= ttl:
			queue_free()
