tool
extends Sprite

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (float) var playerMovementSpeed

var y_upper_boundary = 483.57
var y_lower_boundary = 111.373
var timer = 0

func _ready():
	if (playerMovementSpeed == 0):
		playerMovementSpeed = 240 #default value for player movement speed
	print(OS.window_size)
	pass

func _process(delta):
	control_player(delta)
	increase_speed()
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]

func control_player(delta):
	if (is_player_one):
		if Input.is_key_pressed(KEY_W) and not Input.is_key_pressed(KEY_S):
			if (self.position.y > y_lower_boundary):
				self.position.y -= (playerMovementSpeed * delta)
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < y_upper_boundary):
				self.position.y += (playerMovementSpeed * delta)
	elif (is_player_two):
		if Input.is_key_pressed(KEY_I) and not Input.is_key_pressed(KEY_K):
			if (self.position.y > y_lower_boundary):
				self.position.y -= playerMovementSpeed * delta
		elif Input.is_key_pressed(KEY_K) and not Input.is_key_pressed(KEY_I):
			if (self.position.y < y_upper_boundary):
				self.position.y += playerMovementSpeed * delta
			
#Speed increased by every minute
func increase_speed():
	timer += 1
	if (timer / 60000 == 1):
		playerMovementSpeed += 50
		timer = 0
		
	
