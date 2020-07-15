tool
extends Sprite

export (bool) var is_player_one
export (bool) var update
export (Array) var playerTextures

func _ready():
	pass

func _process(delta):
	if update:
		if Engine.editor_hint:
			texture = playerTextures[0] if (is_player_one) else playerTextures[1]
