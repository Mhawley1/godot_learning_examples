extends "res://character/character.gd"

func _ready():
	$Sprite.scale = Vector2(1,1)
signal moved 

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					emit_signal('moved') 
