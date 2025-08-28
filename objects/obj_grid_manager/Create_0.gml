/// @desc Define grid
randomise();
// Variables
horizontal_movement_cooldown = 15;
horizontal_movement_timer = horizontal_movement_cooldown;
#region Create grid
game_grid = [];
var _block_size = sprite_get_width(spr_block_empty);
var _grid_width = 8;
var _grid_height = 16;
var _start_x = (room_width / 2) - ((_grid_width / 2) * _block_size);
var _start_y = (room_height / 2) - ((_grid_height / 2) * _block_size);
for (var i = 0; i < _grid_width; i++)
{
	for (var j = 0; j < _grid_height; j++)
	{
		game_grid[i][j] = instance_create_layer(_start_x + (_block_size * i),
			_start_y + (_block_size * j), layer, obj_block);
		with (game_grid[i][j])
		{
			position.xx = i;
			position.yy = j;
		}
		game_grid[i][j].parent_grid = game_grid;
	}
}
#endregion
function game_cluster(_grid, _cluster_source) : cluster(_grid) constructor
{
	normal_fall_timer = 40
	fast_fall_timer = 10
	current_fall_timer = 40
	is_falling_faster = false
	cluster_source = _cluster_source;
	
	/// @func get_next_cluster();
	/// @desc Gets next cluster from preview
	get_next_cluster = function()
	{
		shape_type = cluster_source.shape_type;
		for (var i = 0; i < array_length(block_points); i++)
		{
			block_points[i].position.xx = cluster_source.block_points[i].position.xx;
			block_points[i].position.yy = cluster_source.block_points[i].position.yy;
			block_points[i].block_shape = cluster_source.block_points[i].block_shape;
		}
		generate_cluster_in_grid();
		cluster_source.create_next_cluster();
	}
	
	/// @func fall();
	/// @desc Cluster falls by 1 block
	fall = function()
	{
		// Reset fall timer
		current_fall_timer = normal_fall_timer;
		if (is_falling_faster) current_fall_timer = fast_fall_timer;
		// No cluster, so generate new one at top of grid
		if shape_type == CLUSTER_TYPE.NONE
		{
			get_next_cluster();
		}
		else
		{
			clear_cluster_from_grid();
			// Check there is space below cluster for it to fall into
			var _is_space = true;
			for (var i = 0; i < array_length(block_points); i++)
			{
				var _x = block_points[i].position.xx;
				var _y = block_points[i].position.yy;
				if (_y + 1) >= array_length(block_grid[0])
				{
					_is_space = false;
					break;
				}
				else if block_grid[_x, _y + 1].state != BLOCK_STATE.EMPTY
				{
					_is_space = false;
					break;
				}
			}
			// Generate cluster
			if !_is_space
			{
				// Regenerate cluster in same space
				generate_cluster_in_grid();
				// Cluster is set
				shape_type = CLUSTER_TYPE.NONE;
				obj_grid_manager.check_grid_for_tile_match();
			}
			else
			{
				// Generate cluster 1 space down
				for (var i = 0; i < array_length(block_points); i++)
					block_points[i].position.yy++;
				generate_cluster_in_grid();
			}
		}
	}
	
	/// @func fall_faster(_is_faster);
	/// @param {Bool} _is_faster True if cluster should fall faster, false if not
	fall_faster = function(_is_faster)
	{
		if _is_faster
		{
			is_falling_faster = true;
			fall();
		}
		else
		{
			is_falling_faster = false;
			current_fall_timer = normal_fall_timer;
		}
	}
	
	/// @func move_horizontally(_dir);
	/// @param {Real} _dir The direction for the cluster to move in horizontally
	/// @desc Cluster moves 1 block left or right
	move_horizontally = function(_dir)
	{
		if shape_type != CLUSTER_TYPE.NONE
		{
			clear_cluster_from_grid();
			// Check there is space for cluster to move into
			var _is_space = true;
			for (var i = 0; i < array_length(block_points); i++)
			{
				var _new_x = block_points[i].position.xx + _dir;
				var _y = block_points[i].position.yy;
				if (_new_x >= array_length(block_grid)) || (_new_x < 0)
				{
					_is_space = false;
					break;
				}
				else if block_grid[_new_x, _y].state != BLOCK_STATE.EMPTY
				{
					_is_space = false;
					break;
				}
			}
			// Move cluster 1 space to the left or right
			if (_is_space) for (var i = 0; i < array_length(block_points); i++)
				block_points[i].position.xx += _dir;
			// Regenerate cluster
			generate_cluster_in_grid();
		}
	}
	
	/// @func rotate(_dir);
	/// @param {Real} _dir The direction the cluster is rotating
	/// @desc Cluster rotates 90 degrees clockwise or anti-clockwise
	rotate = function(_dir)
	{
		if shape_type != CLUSTER_TYPE.NONE
		{
			clear_cluster_from_grid();
			// Attempt to rotate cluster
			if shape_type == CLUSTER_TYPE.BLOCK
			{
				// Block cluster type - just rotate the block shapes
				var _new_points = array_create(4, BLOCK_STATE.EMPTY);
				if _dir == 1
				{
					// Rotate all block shapes clockwise
					_new_points[0] = block_points[2].block_shape;
					_new_points[1] = block_points[0].block_shape;
					_new_points[2] = block_points[3].block_shape;
					_new_points[3] = block_points[1].block_shape;
				}
				else
				{
					// Rotate all block shapes anti-clockwise
					_new_points[0] = block_points[1].block_shape;
					_new_points[1] = block_points[3].block_shape;
					_new_points[2] = block_points[0].block_shape;
					_new_points[3] = block_points[2].block_shape;
				}
				// Assign block shapes to block points
				for (var i = 0; i < array_length(block_points); i++)
					block_points[i].block_shape = _new_points[i];
			}
			else
			{
				// Rotate the entire cluster, trying different origin points
				if !try_rotate_cluster(1, 90 * _dir)
				{
					if !try_rotate_cluster(2, 90 * _dir)
					{
						if !try_rotate_cluster(0, 90 * _dir)
							try_rotate_cluster(3, 90 * _dir);
					}
				}
			}
			// Regenerate cluster
			generate_cluster_in_grid();
		}
	}
	
	/// @func try_rotate_cluster(_origin_index, _rotation_angle);
	/// @param {Real} _origin_index The index of the block point that will be used as the origin of rotation
	/// @param {Real} _rotation_angle The angle at which the cluster will be rotated (either 90 or -90 degrees)
	/// @return {Bool} True if rotation was successful, false if not
	/// @desc Attempts to rotate a cluster
	try_rotate_cluster = function(_origin_index, _rotation_angle)
	{
		// Calculate new points for each block in cluster
		var _new_points = [new vector2(0, 0), new vector2(0, 0), new vector2(0, 0),
			new vector2(0, 0)];
		for (var i = 0; i < array_length(block_points); i++)
		{
			if i == _origin_index
			{
				// Origin stays at same point
				_new_points[i].xx = block_points[i].position.xx;
				_new_points[i].yy = block_points[i].position.yy;
			}
			else
			{
				// Calculate new point
				// Source for rotation algorithm:
				// https://www.baeldung.com/cs/tetris-piece-rotation-algorithm
				var _x = block_points[i].position.xx -
					block_points[_origin_index].position.xx;
				var _y = block_points[i].position.yy -
					block_points[_origin_index].position.yy;
				var _xx = round(_x * dcos(_rotation_angle) -
					_y * dsin(_rotation_angle));
				var _yy = round(_x * dsin(_rotation_angle) +
					_y * dcos(_rotation_angle));
				_new_points[i].xx = _xx + block_points[_origin_index].position.xx;
				_new_points[i].yy = _yy + block_points[_origin_index].position.yy;
			}
		}
		// Check there is space for new points
		var _is_space = true;
		for (var i = 0; i < array_length(_new_points); i++)
		{
			// No need to check origin point
			if i != _origin_index
			{
				if (_new_points[i].xx < 0) || (_new_points[i].yy < 0) ||
					(_new_points[i].xx >= array_length(block_grid)) ||
					(_new_points[i].yy >= array_length(block_grid[0])) ||
					(block_grid[_new_points[i].xx, _new_points[i].yy].state !=
					BLOCK_STATE.EMPTY)
				{
					_is_space = false;
					break;
				}
			}
		}
		// Rotate cluster points
		if _is_space
		{
			for (var i = 0; i < array_length(block_points); i++)
			{
				// Origin point doesn't change
				if i != _origin_index
				{
					block_points[i].position.xx = _new_points[i].xx;
					block_points[i].position.yy = _new_points[i].yy;
				}
			}
		}
		return _is_space;
	}
}
current_cluster = new game_cluster(game_grid, obj_game_manager.next_cluster);
#region Grid functions
/// @func check_grid_for_tile_match();
/// @desc Checks grid for any vertical or horizontal block matches of 3+ in a row
check_grid_for_tile_match = function()
{
	var _match_found = false;
	do
	{
		_match_found = false
		// Arrays for flagging matches
		var _horizontal_match = [];
		for (var i = 0; i < array_length(game_grid); i++)
		{
			for (var j = 0; j < array_length(game_grid[0]); j++)
				_horizontal_match[i][j] = 0;
		}
		var _vertical_match = [];
		for (var i = 0; i < array_length(game_grid); i++)
		{
			for (var j = 0; j < array_length(game_grid[0]); j++)
				_vertical_match[i][j] = 0;
		}
		// Check for matches
		for (var i = 0; i < array_length(game_grid); i++)
		{
			for (var j = 0; j < array_length(game_grid[0]); j++)
			{
				if game_grid[i][j].state != BLOCK_STATE.EMPTY
				{
					// Check for horizontal match
					if !_horizontal_match[i][j]
					{
						var _matches = game_grid[i][j].get_horizontal_matches();
						if array_length(_matches) >= MIN_MATCH
						{
							var _additional_points = 5 * (array_length(_matches) - MIN_MATCH);
							// Add points to matched blocks
							for (var k = 0; k < array_length(_matches); k++)
							{
								var _xx = _matches[k].xx;
								var _yy = _matches[k].yy;
								_horizontal_match[_xx][_yy] = 10 + _additional_points;
							}
						}
					}
					// Check for vertical match
					if !_vertical_match[i][j]
					{
						var _matches = game_grid[i][j].get_vertical_matches();
						if array_length(_matches) >= MIN_MATCH
						{
							var _additional_points = 5 * (array_length(_matches) - MIN_MATCH);
							// Add points to matched blocks
							for (var k = 0; k < array_length(_matches); k++)
							{
								var _xx = _matches[k].xx;
								var _yy = _matches[k].yy;
								_vertical_match[_xx][_yy] = 10 + _additional_points;
							}
						}
					}
				}
			}
		}
		// Remove all matches
		for (var i = 0; i < array_length(game_grid); i++)
		{
			for (var j = 0; j < array_length(game_grid[0]); j++)
			{
				if (_horizontal_match[i][j] > 0) || (_vertical_match[i][j] > 0)
				{
					// Remove block and add points
					game_grid[i][j].explode();
					_match_found = true;
					global.player_score += _horizontal_match[i][j] + _vertical_match[i][j];
				}
			}
		}
		if (_match_found) fill_gaps();
	}
	until (!_match_found)
}

/// @func fill_gaps();
/// @desc Moves blocks down to fill gaps after matches are removed
fill_gaps = function()
{
	var _block_moved = false;
	// Check grid for gaps and move blocks down to fill gaps
	// Repeat until no gaps are found
	do
	{
		_block_moved = false;
		for (var i = 0; i < array_length(game_grid); i++)
		{
			for (var j = 0; j < array_length(game_grid[0]) - 1; j++)
			{
				if (game_grid[i][j].state != BLOCK_STATE.EMPTY) &&
					(game_grid[i][j + 1].state == BLOCK_STATE.EMPTY)
				{
					game_grid[i][j + 1].change_state(game_grid[i][j].state);
					game_grid[i][j].change_state(BLOCK_STATE.EMPTY);
					_block_moved = true;
				}
			}
		}
	}
	until (!_block_moved)
}
#endregion