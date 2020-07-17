extends Area2D

export(int) var Speed = 1000


var speed = 750
var player


func start(pos, dir, playerNumber):
	rotation = dir
	position = pos
	player = playerNumber
	
func _physics_process(delta):
	position += Vector2(
		cos(rotation) * speed * delta, 
		sin(rotation) * speed * delta
	)
	if (position.y < 100 or position.y > 490):
		print("off bounds")
		self.queue_free()
	
	if (player == "playerOne"):
		if (position.x > 830):
			print("Player 1 scored")
			if (get_parent().get_child(2).lower_player_health(10, false) == 0):
				get_parent().game_over("Player One")
			
			
			self.queue_free()
	else:
		if (position.x < 200):
			print("Player 2 scored")
			if (get_parent().get_child(2).lower_player_health(10, true) == 0):
				get_parent().game_over("Player Two")
			self.queue_free()

func _on_Bullet_body_enter(body):
	print("yes")
	
func isBullet():
	return true
	
func getBulletOwner():
	return player
	

func _on_Bullet_area_entered(area):
	print("disappear")
	pass # Replace with function body.
