extends Node2D

var screen_size
var extents
#var textures = {'1':['res://sprites/haystack.png'],
#				'2':['res://sprites/wood.png']}

func _ready():
	add_to_group("barricade")
#	init('1')
	
#func init(level):
#	var texture = load(textures[level])
#	get_node("barricade").set_texture(texture)
	
func explode():
	queue_free()

## Destination for barricade build in Main
# var barricade = preload("res://scenes/Barricade.tscn")
# var player_position = PlayerOne.transform.origin
# var player_forward_vector = player.global_tranform.basis.x
# var barricade_instance = barricade_scene.instance()
# func spawn_barricade():
# 	if (is_player_one):
#		if Input.is_key_pressed(KEY_E):
# 			player_forward_vector = player_forward_vector.normalized()
# 			var spawn_position = player_position
# 			spawn position.x += player_forward_vector.x * 3
# 			barricade_instance.transform.origin = spawn_position
# 	elif (is_player_two):
# 		if Input.is_key_pressed(KEY_O):
# 			player_forward_vector = player_forward_vector.normalized()
# 			var spawn_position = player_position
# 			spawn position.x -= player_forward_vector.x * 3
# 			barricade_instance.transform.origin = spawn_position


###For Bullet.tscn so that both the bullet and barrier disappears when hit
#func _on_player_bullet_body_enter(body):
#	if body.get_groups().has("barricade"):
#		queue_free()
#		body.explode()



func _on_Barricade_area_entered(area):
	if area.isBullet() and area.getBulletOwner() == "playerTwo":
		self.queue_free()
		area.queue_free()
