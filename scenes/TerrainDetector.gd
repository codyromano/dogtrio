extends Area2D

var hero: CharacterBody2D
var tile_map: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	hero = get_node("/root/Level 1/Hero")
	tile_map = get_node("/root/Level 1/TileMap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_pipe_rim_collision(_body_rid, tile_coords: Vector2i):
	# Get the adjacent coordinate (pipe body)
	var tile_above: Vector2i = Vector2i(
		tile_coords.x,
		tile_coords.y
	)
	
	var target_global = hero.to_global(tile_coords)
	GlobalSignals.player_pipe_collision.emit(
		Vector2(
			round(target_global.x - 1),
			round(target_global.y - 4)
		)
	, tile_map)
	
func _on_tile_map_collision(body_rid, tile_map: TileMap):
	var tile_coords: Vector2i = tile_map.get_coords_for_body_rid(body_rid)
	# print('tile_coords: ', tile_coords)
	
	for index in tile_map.get_layers_count():
		var cell_data = tile_map.get_cell_tile_data(index, tile_coords)
		if (!cell_data is TileData):
			continue
		
		var tile_name = cell_data.get_custom_data_by_layer_id(0)
		if (tile_name == "pipe"):
			_on_pipe_rim_collision(body_rid, tile_coords)
			


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body is TileMap):
		_on_tile_map_collision(body_rid, body)
