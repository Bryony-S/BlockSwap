/// @func vector2(_xx, _yy);
/// @param {Real} _xx The x co-ordinate
/// @param {Real} _yy The y co-ordinate
/// @desc A struct for storing x and y co-ordinates
function vector2(_xx, _yy) constructor
{
	xx = _xx;
	yy = _yy;
}

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