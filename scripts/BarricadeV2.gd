extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("barricadev2")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Haystack_area_entered(area):
	if area.isBullet() and area.getBulletOwner() == "playerOne":
		self.queue_free()
		area.queue_free()
