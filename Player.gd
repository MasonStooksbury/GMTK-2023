extends "res://BasePlayer.gd"

func _ready():
	empty_ammo()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_left", "p1_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func fillBucket(color):
	change_hud(determine_new_texture(color, ammo))
	ammo += 1

func change_hud(new_texture):
	get_parent().get_node('CanvasLayer/P1Ammo').texture = new_texture
	
func empty_ammo():
	change_hud(Global.empty)
