#region vector2
/// @func vector2(_xx, _yy);
/// @param {Real} _xx The x co-ordinate
/// @param {Real} _yy The y co-ordinate
/// @desc A struct for storing x and y co-ordinates
function vector2(_xx, _yy) constructor
{
	xx = _xx;
	yy = _yy;
}
#endregion
#region point
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
#region cluster
/// @func cluster();
/// @param {Array<Array<Id.Instance>>} _grid The block grid the cluster is assigned to
/// @desc Creates a cluster shape of blocks
function cluster(_grid) constructor
{
	block_grid = _grid;
	block_points = [new point(), new point(), new point(), new point()];
	shape_type = CLUSTER_TYPE.NONE;
	
	/// @func generate_cluster_in_grid();
	/// @desc Creates cluster in grid
	generate_cluster_in_grid = function()
	{
		for (var i = 0; i < array_length(block_points); i++)
		{
			var _x = block_points[i].position.xx;
			var _y = block_points[i].position.yy;
			if (block_grid[_x, _y].state) == BLOCK_STATE.EMPTY
			{
				block_grid[_x, _y].change_state(block_points[i].block_shape);
			}
			else // Game over
			{
				room_restart();
			}
		}
	}
	
	/// @func clear_cluster_from_grid();
	/// @desc Clears cluster from grid
	clear_cluster_from_grid = function()
	{
		for (var i = 0; i < array_length(block_points); i++)
		{
			var _x = block_points[i].position.xx;
			var _y = block_points[i].position.yy;
			block_grid[_x, _y].change_state(BLOCK_STATE.EMPTY);
		}
	}
}
#endregion