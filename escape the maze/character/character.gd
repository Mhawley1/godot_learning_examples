extends Area2D

signal dead
signal grabbed_key
signal win

export (int) var speed

var tile_size = 64
var can_move = true

var facing = 'right'
var moves = {'right':Vector2(1,0), # this is a dictonary,, 
'left':Vector2(-1,0),
'up':Vector2(0,-1),
'down':Vector2(0,1)}

onready var raycasts = {'right':$RayCastRight, # this is a dictionary
	'left': $RayCastLeft,
	'up': $RayCastUp,
	'down': $RayCastDown}
	
func move(dir):
	$AnimationPlayer.playback_speed = speed
	facing = dir
	if raycasts[facing].is_colliding():
		return
	can_move = false
	$AnimationPlayer.play(facing)
	$MoveTween.interpolate_property(self,"position",
		position,position + moves[facing] * tile_size,
		1.0/speed, Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$MoveTween.start()
	return true



func _on_MoveTween_tween_completed(object, key):
	can_move = true
	



func _on_character_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		set_process(false)
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, "animation_finished")
		emit_signal('dead')
	if area.has_method('pickup'):
		print("we have an item")
		area.pickup()
		if area.type == 'key_red':
			emit_signal('grabbed_key')
		if area.type == 'star':
			emit_signal('win')
	
