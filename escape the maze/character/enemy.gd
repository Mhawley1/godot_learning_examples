extends "res://character/character.gd"


func _ready():
	can_move = false
	facing = moves.keys()[randi() % 4] # refers back to the dictionary with the vec2 directions
	yield(get_tree().create_timer(0.5), 'timeout')  
	can_move = true
func _process(delta):
	if can_move:
		if move(facing) or randi() % 10 > 5: # this is where the move is executed in the move function 
			facing = moves.keys()[randi() % 4]
			
			# remember not is removed 
