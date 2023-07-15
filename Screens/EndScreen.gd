extends Control

@onready var label = $MarginContainer/Menu/Label


func _ready():
	label.text = '%s wins!' % (Global.players['Player2'].name if Global.players['Player1'].is_dead else Global.players['Player1'].name)
