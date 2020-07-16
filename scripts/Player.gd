tool
extends Sprite

export (bool) var is_player_one
export (bool) var is_player_two
export (bool) var update
export (Array) var playerTextures
export (int) var playerMovementSpeed

func _ready():
	pass

func _process(delta):
	control_player(delta)
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]

func control_player(delta):
	if (is_player_one):
		if Input.is_key_pressed(KEY_W) and not Input.is_key_pressed(KEY_S):
			if (self.position.y > 111.373):
				self.position.y -= 5
		elif Input.is_key_pressed(KEY_S) and not Input.is_key_pressed(KEY_W):
			if (self.position.y < 483.579):
				self.position.y += 5
	elif (is_player_two):
		if Input.is_key_pressed(KEY_I) and not Input.is_key_pressed(KEY_K):
			if (self.position.y > 111.373):
				self.position.y -= 5
		elif Input.is_key_pressed(KEY_K) and not Input.is_key_pressed(KEY_I):
			if (self.position.y < 483.579):
				self.position.y += 5
				

	
