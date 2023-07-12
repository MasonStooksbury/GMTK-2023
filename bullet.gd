extends RigidBody2D

var color: String
var shooter: String
var has_bounced: bool



func setup(player_color: String, color_of_ammo):
	self.color = color_of_ammo
	self.shooter = player_color
	$Sprite2D.texture = Global.blob_textures[color_of_ammo]



# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.



func _on_body_entered(body):
	if body.is_in_group('player') and body.player_color != self.shooter:
		body.process_hit(self.color)
		queue_free()
	else:
		if self.has_bounced:
			queue_free()
		else:
			self.has_bounced = true



func _on_timer_timeout():
	queue_free()
