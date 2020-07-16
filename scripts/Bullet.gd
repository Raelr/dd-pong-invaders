extends Area2D

export(int) var Speed = 1000

var speed = 750

func start(pos, dir):
	rotation = dir
	position = pos
	
func _physics_process(delta):
	position += Vector2(
		cos(rotation) * speed * delta, 
		sin(rotation) * speed * delta
	)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
