extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for h in get_children():
		h.set_frame(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display_health(amt: int):
	for h in get_children():
		if amt >= 2:
			h.set_frame(2)
			amt -= 2
		elif amt >= 1:
			h.set_frame(1)
			amt -= 1
		else:
			h.set_frame(0)
		
