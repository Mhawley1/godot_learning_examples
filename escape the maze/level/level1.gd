extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Pickup

onready var items = $items
var door = []

func _ready():
	randomize()
	$items.hide()
	set_camera_limits()
	var door_id = $walls.tile_set.find_tile_by_name('door_red')
	for cell in $walls.get_used_cells_by_id(door_id):
		door.append(cell)
	spawn_items()
	$Player.connect('dead', self, 'game_over')
	$Player.connect('grabbed_key', self, '_on_Player_grabbed_key')
	$Player.connect('win', self, '_on_Player_win')
	
func set_camera_limits():
		var map_size = $ground.get_used_rect()
		var cell_size = $ground.cell_size
		$Player/Camera2D.limit_left = map_size.position.x * cell_size.x
		$Player/Camera2D.limit_top = map_size.position.y * cell_size.y
		$Player/Camera2D.limit_right = map_size.end.x * cell_size.x
		$Player/Camera2D.limit_bottom = map_size.end.y * cell_size.y
		
func spawn_items():
	for cell in items.get_used_cells(): # gives 2d array of all item cells
		var id = items.get_cellv(cell) # the id is equal to the index of the array
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell) + items.cell_size/2
		match type:
			'slime_spawn':
				var s = Enemy.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'player_spawn':
				$Player.position = pos
				$Player.tile_size = items.cell_size
			'coin','key_red','star':
				var p = Pickup.instance()
				p.init(type, pos)
				add_child(p)
func game_over():
	Global.game_over()
func _on_Player_win():
	Global.next_level()
func _on_Player_grabbed_key():
	for cell in door:
		$walls.set_cellv(cell,-1)
		
		
