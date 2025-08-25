/// @desc Define block variables and functions
state = BLOCK_STATE.EMPTY;

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
