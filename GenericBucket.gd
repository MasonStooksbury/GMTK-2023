extends Area2D
@export_enum('RED', 'BLUE', 'YELLOW', 'REDBLUE', 'REDYELLOW', 'BLUEYELLOW') var color: String

var current_color
var scale_factor = 1.5
var color_cycle = []
var cycle_max = 0
var is_primary = true
var dropped = false
var small_waittime = 10
var big_waittime = 20



# Called when the node enters the scene tree for the first time.
func _ready():
	is_primary = false if color in Global.complex_colors else true
	color_cycle = Global.primary_colors if is_primary else Global.deduped_complex_colors
	cycle_max = 2 if is_primary else 5
	current_color = color_cycle.find(color)
	
	get_node('Sprite2D').texture = Global.bucket_textures[color]
	if not is_primary:
		scale = Vector2(scale_factor, scale_factor)



func _on_body_entered(body):
	var thing = body.fillBucket(color)
	if not thing:
		if not dropped:
			self.visible = false
			set_deferred('monitoring', false)
			$RespawnTimer.wait_time = small_waittime if is_primary else big_waittime
			$RespawnTimer.start()
		else:
			queue_free()



func _on_spawn_timer_ready():
	set_deferred('monitoring', false)
func _on_spawn_timer_timeout():
	set_deferred('monitoring', true)



func _on_color_change_timer_timeout():
	current_color += 1
	current_color = 0 if current_color > cycle_max else current_color
	color = color_cycle[current_color]
	get_node('Sprite2D').texture = Global.bucket_textures[color]



func _on_respawn_timer_timeout():
	self.visible = true
	set_deferred('monitoring', true)
