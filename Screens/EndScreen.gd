extends Control



func _ready():
	$MarginContainer/Menu/Label.text = '%s wins!' % (Global.players['Player2'].name if Global.players['Player1'].is_dead else Global.players['Player1'].name)
