/// @desc Define block variables and functions
state = BLOCK_STATE.EMPTY;
position = new vector2(0, 0);
#region Functions
/// @func change_state(_new_state);
/// @param {Enum.BLOCK_STATE} _new_state The block's new state
/// @desc Changes block's state
change_state = function(_new_state)
{
	state = _new_state;
	// Change sprite
	switch (state)
	{
		case BLOCK_STATE.EMPTY:
			sprite_index = spr_block_empty;
			break;
		case BLOCK_STATE.SQUARE:
			sprite_index = spr_block_square;
			break;
		case BLOCK_STATE.CIRCLE:
			sprite_index = spr_block_circle;
			break;
		case BLOCK_STATE.DIAMOND:
			sprite_index = spr_block_diamond;
			break;
		case BLOCK_STATE.TRIANGLE:
			sprite_index = spr_block_triangle;
			break;
	}
}

/// @func get_horizontal_matches();
/// @return {Array<Struct.vector2>} An array containing positions of all blocks in the match (including this block)
/// @desc Finds and returns all horizontal matches with this block
get_horizontal_matches = function()
{
	var _matches = [position];
	// Check for matches to the right
	if position.xx <= (array_length(global.block_grid) - MIN_MATCH)
	{
		for (var i = position.xx + 1; i < array_length(global.block_grid); i++)
		{
			var _block = global.block_grid[i][position.yy];
			if _block.state == state
			{
				array_push(_matches, _block.position);
			}
			else {break;}
		}
	}
	return _matches;
}

/// @func get_vertical_matches();
/// @return {Array<Struct.vector2>} An array containing positions of all blocks in the match (including this block)
/// @desc Finds and returns all vertical matches with this block
get_vertical_matches = function()
{
	var _matches = [position];
	// Check for matches going down
	if position.yy <= (array_length(global.block_grid[0]) - MIN_MATCH)
	{
		for (var i = position.yy + 1; i < array_length(global.block_grid[0]); i++)
		{
			var _block = global.block_grid[position.xx][i];
			if _block.state == state
			{
				array_push(_matches, _block.position);
			}
			else {break;}
		}
	}
	return _matches;
}
#endregion