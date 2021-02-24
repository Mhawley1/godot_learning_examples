extends Area2D

signal coin_pickup

var textures = {
	'coin': 'res://assets/coin.png',
	'key_red': 'res://assets/keyRed.png',
	'key_green': 'res://assets/keygreen.png',
	'star': 'res://assets/star.png'
	}

var type

func _ready(): # these are just the tweens when the ready takes place , whenever that is
	$Tween.interpolate_property($Sprite, 'scale', Vector2(1,1),
	Vector2(3,3),0.5,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Sprite, 'modulate',Color(1,1,1,1),Color(1,1,1,0),0.5,
	Tween.TRANS_QUAD,Tween.EASE_IN_OUT)

func init(_type, pos):   # function that takes in the type and Position and sets to the scene. 
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	
	# this basically assignes the correct texture and positon 


func _on_Tween_tween_completed(object, key):
	queue_free() # remove the pickup node or whater item 
	# it is !!!!!!!!!
	
func pickup():
	match type:
		'coin':
			emit_signal('coin_pickup', 1)
	$CollisionShape2D.set_deferred("disabled", true)
	$Tween.start()
