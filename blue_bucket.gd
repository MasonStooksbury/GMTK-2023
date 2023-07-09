extends Area2D
var color = 'BLUE'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	body.fillBucket(color)
	queue_free()
