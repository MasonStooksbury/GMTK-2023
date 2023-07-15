extends RigidBody2D

@onready var timer = $Timer

var color: String
var shooter: String
var has_bounced: bool




func setup(player_color: String, color_of_ammo, dir: String):
	self.color = color_of_ammo
	self.shooter = player_color
	$Sprite2D.flip_h = true if dir == 'LEFT' else false
	$PaintTrail.process_material.direction = Vector3(1,0,0) if dir == 'RIGHT' else Vector3(-1,0,0)
	$PaintTrail.process_material.color = Color.hex(Global.color_vals[color_of_ammo])
	# Despite the pattern, I have to put $Sprite2D here for this to work
	# Something to do with onready and how the scene tree works. I'll dig into it later
	$Sprite2D.texture = Global.blob_textures[color_of_ammo]



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()



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
