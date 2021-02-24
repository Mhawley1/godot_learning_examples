extends Node

var levels = ['res://level/level1.tscn',
'res://level/level2.tscn']

var current_level = 0
var score = 0
var start_screen = 'res://level/StartScreen.tscn'
var end_screen = 'res://level/EndScreen.tscn'
#var num_level = levels.size() not used , just for testing 

func new_game():
	current_level = -1
	score = 0
	next_level()

func game_over():
	get_tree().change_scene(end_screen)

func next_level():
	current_level += 1
	if current_level >= Global.levels.size():  # returns teh size of a dictionary 
		# no more levels to load 
		game_over()
	else:
		get_tree().change_scene(levels[current_level])
