extends RigidBody2D

var color: String
var shooter: String
var has_bounced: bool

func setup(shooter: String, color):
	self.color = color
	self.shooter = shooter
	$Sprite2D.texture = Global.blob_textures[color]
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	var bodies = get_colliding_bodies()
	if bodies[0].is_in_group('player'):
		if bodies[0].player_color != shooter:
			bodies[0].process_hit(color)
			queue_free()
	else:
		if has_bounced:
			queue_free()
		else:
			has_bounced = true


func _on_timer_timeout():
	queue_free()
