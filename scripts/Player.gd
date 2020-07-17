tool
extends Sprite

var is_paused : bool = false

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (float) var playerMovementSpeed

var bullet_time_multiplier = 0
var y_upper_boundary = 483.57
var y_lower_boundary = 111.373
var timer = 0

var recoilTime = 1

var Bullet = preload("res://scenes/Bullet.tscn")
var canShoot = true

var isPlayerOneStunned = false
var isPlayerTwoStunned = false

var playerState = 0

var has_power_up : bool = false
var powerup_duration : float = 0.0
var powerup_elapsed_time : float = 0.0

#Build Barricade
var barricade = preload("res://scenes/Barricade.tscn")
var barricadev2 = preload("res://scenes/BarricadeV2.tscn")

const max_barricade_P1 = 5
const max_barricade_P2 = 5

func _ready():
	if (playerMovementSpeed == 0):
		playerMovementSpeed = 240 #default value for player movement speed
	print(OS.window_size)
	pass

func _process(delta):
	
	if not is_paused and !Engine.editor_hint:
		control_player(delta)
		check_for_powerups(delta)
		
		if playerState == 2:
			recoilTime = 0.5

	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]

func reset_player():
	# set player to unmodified state
	has_power_up = false
	recoilTime = 1
	playerState = 0
	modulate = Color.white

func check_for_powerups(delta):
	if has_power_up:
		powerup_elapsed_time += delta
		if powerup_elapsed_time >= powerup_duration:
			reset_player()
			powerup_elapsed_time = 0
			print("removed powerup")

func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)

func catchUserShootInput():
	if (is_player_one):
		if Input.is_key_pressed(KEY_F):
			debounceShot(0, "playerOne")
	else:
		if Input.is_key_pressed(KEY_H):
			debounceShot(PI, "playerTwo")

func debounceShot(angle, player):
	if canShoot:
		shootBullet(angle, player)
		
		var recoilTimer = recoilTimer(recoilTime, "onRecoilTimerStopped")
		recoilTimer.start()
		canShoot = false

func singleShot(angle, player):
	var bullet = Bullet.instance()
	
	bullet.speed += bullet_time_multiplier
	
	bullet.start(global_position, angle, player)
	
	get_parent().add_child(bullet)

func trippleShot(angle, player):
	var b1 = Bullet.instance()
	var b2 = Bullet.instance()
	var b3 = Bullet.instance()
	
	b1.speed += bullet_time_multiplier
	b2.speed += bullet_time_multiplier
	b3.speed += bullet_time_multiplier
	
	b1.start(global_position, angle - PI / 12, player) # top
	b2.start(global_position, angle, player) # middle
	b3.start(global_position, angle + PI / 12, player) # bottom
	
	get_parent().add_child(b1)
	get_parent().add_child(b2)
	get_parent().add_child(b3)

func shootBullet(angle, player):
	if playerState == 3:
		trippleShot(angle, player)
	else:
		singleShot(angle, player)

func onRecoilTimerStopped():
	canShoot = true

func control_player(delta):
	if (is_player_one and !isPlayerOneStunned):
		catchUserShootInput()
		if Input.is_key_pressed(KEY_W) and not Input.is_key_pressed(KEY_S):
			if (self.position.y > y_lower_boundary):
				self.position.y -= (playerMovementSpeed * delta)
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < y_upper_boundary):
				self.position.y += (playerMovementSpeed * delta)
	elif (!is_player_one and !isPlayerTwoStunned):		
		catchUserShootInput()
		if Input.is_key_pressed(KEY_I) and not Input.is_key_pressed(KEY_K):
			if (self.position.y > y_lower_boundary):
				self.position.y -= playerMovementSpeed * delta
		elif Input.is_key_pressed(KEY_K) and not Input.is_key_pressed(KEY_I):
			if (self.position.y < y_upper_boundary):
				self.position.y += playerMovementSpeed * delta
	if Input.is_action_just_pressed("playerActive"):
		spawn_barricade()
	elif Input.is_action_just_pressed("playerTwoActive"):
		spawn_barricade(false)

func spawn_barricade(p1 = true):
	if is_player_one and p1:
		var barricade_count = []
		var player_position = transform.origin
		var barricade_instance = barricade.instance()
		var spawn_position = Vector2()
		get_parent().add_child(barricade_instance)
		if (get_tree().get_nodes_in_group("barricade").size()) <= max_barricade_P1:
			spawn_position.x = 300
			spawn_position.y = player_position.y
			barricade_instance.transform.origin = spawn_position
			print(spawn_position)
			barricade_count.append(barricade_instance)
		else:
			print("No more barricades")
#		spawn_position.x = 300
#		spawn_position.y = player_position.y
#		barricade_instance.transform.origin = spawn_position
#		print(spawn_position)
		
	elif not is_player_one and not p1:
		var barricadev2_count = []
		var player_position = transform.origin
		var barricadev2_instance = barricadev2.instance()
		var spawn_position = Vector2()
		get_parent().add_child(barricadev2_instance)
		if (get_tree().get_nodes_in_group("barricadev2").size()) <= max_barricade_P2:
			spawn_position.x = 730
			spawn_position.y = player_position.y
			barricadev2_instance.transform.origin = spawn_position
			print(spawn_position)
			barricadev2_count.append(barricadev2_instance)
		else:
			print("No more barricades")

#Speed increased by every minute
func increase_speed():
	playerMovementSpeed += 50
	bullet_time_multiplier += 50

func recoilTimer(time, callback):

	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", self, callback)
	timer.set_wait_time(time)
	
	self.add_child(timer)
	
	return timer

func _on_Player2D_area_entered(area):
	if (is_player_one):
		if (area.getBulletOwner() == "playerTwo"):
			if (playerState != 1):
				var timer = recoilTimer(5, "playerOneRecovered")
				timer.start()
				isPlayerOneStunned = true
				get_parent().player_one_stunned = true
				
			area.queue_free()
	else:
		if (area.getBulletOwner() == "playerOne"):
			if (playerState != 1):
				var timer = recoilTimer(5, "playerTwoRecovered")
				timer.start()
				isPlayerTwoStunned = true
				get_parent().player_two_stunned = true
				
			area.queue_free()

func playerOneRecovered():
	isPlayerOneStunned = false
	
func playerTwoRecovered():
	isPlayerTwoStunned = false

func activatePowerup(type : int, player: String):
	# Set different powerup abilities based on the type that's passed in
	if type == 0:
		return
	has_power_up = true
	playerState = type
	
	if type == 1:
		# invulnerability
		powerup_duration = 2.0
		modulate = Color.yellow
	elif type == 2:
		# speed
		powerup_duration = 5.0
		modulate = Color.green
	elif type == 3:
		#shotgun
		powerup_duration = 5.0
		modulate = Color.crimson
