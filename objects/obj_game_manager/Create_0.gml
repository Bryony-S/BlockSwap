/// @desc Start game
draw_set_font(fnt_main);
global.player_score = 0;
#region Create preview grid
preview_grid = [];
var _block_size = sprite_get_width(spr_block_empty);
var _grid_width = 6;
var _grid_height = 4;
var _start_x = 100;
var _start_y = (room_height / 2) - ((_grid_height / 2) * _block_size);
for (var i = 0; i < _grid_width; i++)
{
	for (var j = 0; j < _grid_height; j++)
	{
		preview_grid[i][j] = instance_create_layer(_start_x + (_block_size * i),
			_start_y + (_block_size * j), layer, obj_block);
		with (preview_grid[i][j])
		{
			position.xx = i;
			position.yy = j;
		}
	}
}
#endregion
function preview_cluster(_grid) : cluster(_grid) constructor
{	
	/// @func create_new_shape_points(_shape_type, _start_x, _start_y);
	/// @param {Enum.CLUSTER_TYPE} _shape_type The shape of the cluster
	/// @param {Real} _start_x The grid x point of the top-left corner of the shape
	/// @param {Real} _start_y The grid y point of the top-left corner of the shape
	/// @desc Clears block points and creates a new cluster shape
	create_new_shape_points = function(_shape_type, _start_x, _start_y)
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
	}
		
	/// @func create_next_cluster();
	/// @desc Generates next cluster to drop
	create_next_cluster = function()
	{
		clear_cluster_from_grid();
		shape_type = choose(CLUSTER_TYPE.BLOCK, CLUSTER_TYPE.LINE,
		CLUSTER_TYPE.L_SHAPE, CLUSTER_TYPE.REVERSE_L_SHAPE, CLUSTER_TYPE.S_SHAPE,
		CLUSTER_TYPE.T_SHAPE, CLUSTER_TYPE.Z_SHAPE);
		create_new_shape_points(shape_type, 1, 1);
		generate_cluster_in_grid();
	}
}
next_cluster = new preview_cluster(preview_grid);
next_cluster.create_next_cluster();
instance_create_layer(0, 0, layer, obj_grid_manager);