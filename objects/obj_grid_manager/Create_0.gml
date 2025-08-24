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
	S_SHAPE
}
// Define cluster point
function point(_x, _y) constructor
{
	xx = _x;
	yy = _y;
}
// Define cluster
cluster =
{
	block_points : [],
	/// @func create_new_shape_points(_shape_type, _start_x, _start_y);
	/// @param {Enum.CLUSTER_TYPE} _shape_type The shape of the cluster
	/// @param {Real} _start_x The grid x point of the top-left corner of the shape
	/// @param {Real} _start_y The grid y point of the top-left corner of the shape
	/// @desc Clears block points and creates a new cluster shape
	create_new_shape_points : function(_shape_type, _start_x, _start_y)
	{
		array_clear(block_points);
		switch (_shape_type)
		{
			case CLUSTER_TYPE.BLOCK:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x, _start_y + 1);
				block_points[2] = new point(_start_x + 1, _start_y);
				block_points[3] = new point(_start_x + 1, _start_y + 1);
				break;
			case CLUSTER_TYPE.LINE:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x, _start_y + 1);
				block_points[2] = new point(_start_x, _start_y + 2);
				block_points[3] = new point(_start_x, _start_y + 3);
				break;
			case CLUSTER_TYPE.L_SHAPE:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x, _start_y + 1);
				block_points[2] = new point(_start_x + 1, _start_y);
				block_points[3] = new point(_start_x + 2, _start_y);
				break;
			case CLUSTER_TYPE.REVERSE_L_SHAPE:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x + 1, _start_y);
				block_points[2] = new point(_start_x + 2, _start_y);
				block_points[3] = new point(_start_x + 2, _start_y + 1);
				break;
			case CLUSTER_TYPE.S_SHAPE:
				block_points[0] = new point(_start_x + 1, _start_y);
				block_points[1] = new point(_start_x + 2, _start_y);
				block_points[2] = new point(_start_x, _start_y + 1);
				block_points[3] = new point(_start_x + 1, _start_y + 1);
				break;
			case CLUSTER_TYPE.T_SHAPE:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x + 1, _start_y + 1);
				block_points[2] = new point(_start_x + 1, _start_y);
				block_points[3] = new point(_start_x + 2, _start_y);
				break;
			case CLUSTER_TYPE.Z_SHAPE:
				block_points[0] = new point(_start_x, _start_y);
				block_points[1] = new point(_start_x + 1, _start_y + 1);
				block_points[2] = new point(_start_x + 1, _start_y);
				block_points[3] = new point(_start_x + 2, _start_y + 1);
				break;
		}
	},
	/// @func create_new_cluster();
	/// @desc Creates a new cluster of blocks
	create_new_cluster : function()
	{
		// Set new block points
		create_new_shape_points(choose(CLUSTER_TYPE.BLOCK, CLUSTER_TYPE.LINE,
		CLUSTER_TYPE.L_SHAPE, CLUSTER_TYPE.REVERSE_L_SHAPE, CLUSTER_TYPE.S_SHAPE,
		CLUSTER_TYPE.T_SHAPE, CLUSTER_TYPE.Z_SHAPE),
		irandom(array_length(global.block_grid) - 3), 0);
		// Generate cluster in grid
		for (var i = 0; i < array_length(block_points); i++)
		{
			var _x = block_points[i].xx;
			var _y = block_points[i].yy;
			global.block_grid[_x, _y].change_state_random();
		}
	}
};
cluster.create_new_cluster();
#endregion