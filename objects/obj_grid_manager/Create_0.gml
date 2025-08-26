/// @desc Define grid
randomise();
#region Create grid
global.block_grid = [];
var _block_size = sprite_get_width(spr_block_empty);
var _grid_width = 8;
var _grid_height = 16;
var _start_x = (room_width / 2) - ((_grid_width / 2) * _block_size);
var _start_y = (room_height / 2) - ((_grid_height / 2) * _block_size);
for (var i = 0; i < _grid_width; i++)
{
	for (var j = 0; j < _grid_height; j++)
		global.block_grid[i][j] = instance_create_layer(_start_x + (_block_size * i),
		_start_y + (_block_size * j), "Instances", obj_block);
}
#endregion
#region Define cluster
// Cluster type enum
enum CLUSTER_TYPE
{
	BLOCK,
	T_SHAPE,
	L_SHAPE,
	REVERSE_L_SHAPE,
	LINE,
	Z_SHAPE,
	S_SHAPE,
	NONE
}
#region Define cluster point
/// @func point(_x, _y);
/// @param {Real} _x The x co-ordinate of the cluster point
/// @param {Real} _y The y co-ordinate of the cluster point
/// @desc Represents one block point in the cluster
function point() constructor
{
	position = new vector2(0, 0);
	block_shape = choose(BLOCK_STATE.CIRCLE, BLOCK_STATE.DIAMOND,
		BLOCK_STATE.SQUARE, BLOCK_STATE.TRIANGLE);
	
	change_point = function(_x, _y)
	{
		position.xx = _x;
		position.yy = _y;
		block_shape = choose(BLOCK_STATE.CIRCLE, BLOCK_STATE.DIAMOND,
			BLOCK_STATE.SQUARE, BLOCK_STATE.TRIANGLE);
	}
}
#endregion
#region Define cluster
cluster =
{
	block_points : [new point(), new point(), new point(), new point()],
	shape_type : CLUSTER_TYPE.NONE,
	normal_timer : 30,
	current_timer : 30,
	/// @func create_new_shape_points(_shape_type, _start_x, _start_y);
	/// @param {Enum.CLUSTER_TYPE} _shape_type The shape of the cluster
	/// @param {Real} _start_x The grid x point of the top-left corner of the shape
	/// @param {Real} _start_y The grid y point of the top-left corner of the shape
	/// @desc Clears block points and creates a new cluster shape
	create_new_shape_points : function(_shape_type, _start_x, _start_y)
	{
		switch (_shape_type)
		{
			case CLUSTER_TYPE.BLOCK:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x, _start_y + 1);
				block_points[3].change_point(_start_x + 1, _start_y + 1);
				break;
			case CLUSTER_TYPE.LINE:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x + 2, _start_y);
				block_points[3].change_point(_start_x + 3, _start_y);
				break;
			case CLUSTER_TYPE.L_SHAPE:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x + 2, _start_y);
				block_points[3].change_point(_start_x, _start_y + 1);
				break;
			case CLUSTER_TYPE.REVERSE_L_SHAPE:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x + 2, _start_y);
				block_points[3].change_point(_start_x + 2, _start_y + 1);
				break;
			case CLUSTER_TYPE.S_SHAPE:
				block_points[0].change_point(_start_x, _start_y + 1);
				block_points[1].change_point(_start_x + 1, _start_y + 1);
				block_points[2].change_point(_start_x + 1, _start_y);
				block_points[3].change_point(_start_x + 2, _start_y);
				break;
			case CLUSTER_TYPE.T_SHAPE:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x + 2, _start_y);
				block_points[3].change_point(_start_x + 1, _start_y + 1);
				break;
			case CLUSTER_TYPE.Z_SHAPE:
				block_points[0].change_point(_start_x, _start_y);
				block_points[1].change_point(_start_x + 1, _start_y);
				block_points[2].change_point(_start_x + 1, _start_y + 1);
				block_points[3].change_point(_start_x + 2, _start_y + 1);
				break;
		}
	},
	
	/// @func generate_cluster_in_grid();
	/// @desc Creates cluster in grid
	generate_cluster_in_grid : function()
	{
		for (var i = 0; i < array_length(block_points); i++)
		{
			var _x = block_points[i].position.xx;
			var _y = block_points[i].position.yy;
			global.block_grid[_x, _y].change_state(block_points[i].block_shape);
		}
	},
	
	/// @func clear_cluster_from_grid();
	/// @desc Clears cluster from grid
	clear_cluster_from_grid : function()
	{
		for (var i = 0; i < array_length(block_points); i++)
		{
			var _x = block_points[i].position.xx;
			var _y = block_points[i].position.yy;
			global.block_grid[_x, _y].change_state(BLOCK_STATE.EMPTY);
		}
	},
	
	/// @func create_new_cluster();
	/// @desc Creates a new cluster of blocks
	create_new_cluster : function()
	{
		shape_type = choose(CLUSTER_TYPE.BLOCK, CLUSTER_TYPE.LINE,
		CLUSTER_TYPE.L_SHAPE, CLUSTER_TYPE.REVERSE_L_SHAPE, CLUSTER_TYPE.S_SHAPE,
		CLUSTER_TYPE.T_SHAPE, CLUSTER_TYPE.Z_SHAPE);
		create_new_shape_points(shape_type,
			irandom(array_length(global.block_grid) - 4), 0);
		generate_cluster_in_grid();
	},
	
	/// @func fall();
	/// @desc Cluster falls by 1 block
	fall : function()
	{
		current_timer = normal_timer;
		// No cluster, so generate new one at top of grid
		if shape_type == CLUSTER_TYPE.NONE
		{
			create_new_cluster();
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
				if (_y + 1) >= array_length(global.block_grid[0])
				{
					_is_space = false;
					break;
				}
				else if global.block_grid[_x, _y + 1].state != BLOCK_STATE.EMPTY
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
				// Clear cluster
				shape_type = CLUSTER_TYPE.NONE;
			}
			else
			{
				// Generate cluster 1 space down
				for (var i = 0; i < array_length(block_points); i++)
					block_points[i].position.yy++;
				generate_cluster_in_grid();
			}
		}
	},
	
	/// @func move_horizontally(_dir);
	/// @param {Real} _dir The direction for the cluster to move in horizontally
	/// @desc Cluster moves 1 block left or right
	move_horizontally : function(_dir)
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
				if (_new_x >= array_length(global.block_grid)) || (_new_x < 0)
				{
					_is_space = false;
					break;
				}
				else if global.block_grid[_new_x, _y].state != BLOCK_STATE.EMPTY
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
	},
	
	/// @func rotate(_dir);
	/// @param {Real} _dir The direction the cluster is rotating
	/// @desc Cluster rotates 90 degrees clockwise or anti-clockwise
	rotate : function(_dir)
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
	},
	
	/// @func try_rotate_cluster(_origin_index, _rotation_angle);
	/// @param {Real} _origin_index The index of the block point that will be used as the origin of rotation
	/// @param {Real} _rotation_angle The angle at which the cluster will be rotated (either 90 or -90 degrees)
	/// @return {Bool} True if rotation was successful, false if not
	/// @desc Attempts to rotate a cluster
	try_rotate_cluster : function(_origin_index, _rotation_angle)
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
				var _x = block_points[i].position.xx -
					block_points[_origin_index].position.xx;
				var _y = block_points[i].position.yy -
					block_points[_origin_index].position.yy;
				var _xx = round(_x * dcos(_rotation_angle) - _y * dsin(_rotation_angle));
				var _yy = round(_x * dsin(_rotation_angle) + _y * dcos(_rotation_angle));
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
					(_new_points[i].xx >= array_length(global.block_grid)) ||
					(_new_points[i].yy >= array_length(global.block_grid[0])) ||
					(global.block_grid[_new_points[i].xx, _new_points[i].yy].state !=
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
};
#endregion
#endregion