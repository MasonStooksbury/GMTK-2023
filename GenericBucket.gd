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
var RNG = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	is_primary = false if self.color in Global.complex_colors else true
	color_cycle = Global.primary_colors if is_primary else Global.deduped_complex_colors
	cycle_max = Global.primary_colors.size()-1 if is_primary else Global.deduped_complex_colors.size()-1
	current_color = color_cycle.find(self.color)
	
	change_bucket_texture(color)
	
	if not is_primary:
		scale = Vector2(scale_factor, scale_factor)
		
	$DelayTimer.wait_time = RNG.randf_range(0.0, 1.5)
	$DelayTimer.start()



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



func change_bucket_texture(new_color):
	get_node('Sprite2D').texture = Global.bucket_textures[new_color]



func _on_spawn_timer_ready():
	set_deferred('monitoring', false)
func _on_spawn_timer_timeout():
	set_deferred('monitoring', true)



func _on_color_change_timer_timeout():
	current_color += 1
	current_color = 0 if current_color > cycle_max else current_color
	self.color = color_cycle[current_color]
	change_bucket_texture(self.color)



func _on_respawn_timer_timeout():
	self.visible = true
	set_deferred('monitoring', true)



func _on_delay_timer_timeout():
	$ColorChangeTimer.start()
