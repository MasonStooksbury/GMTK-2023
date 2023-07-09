extends Area2D
@export_enum('RED', 'BLUE', 'YELLOW') var color: String

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('Sprite2D').texture = Global.color_textures[color]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var thing = body.fillBucket(color)
	if not thing:
		queue_free()

func _on_timer_ready():
	monitoring = false

func _on_timer_timeout():
	monitoring = true


