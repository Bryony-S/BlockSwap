/// @desc Define block variables and functions
#region Variables
state = BLOCK_STATE.EMPTY;
position = new vector2(0, 0);
parent_grid = [];
draw_empty = true;
points_visible = false;
points = 0;
#region Explosion particle system
explosion_ps = part_system_create();
part_system_draw_order(explosion_ps, true);
part_system_position(explosion_ps, x, y);
// Explosion part type
explosion_pt = part_type_create();
part_type_shape(explosion_pt, pt_shape_spark);
part_type_size(explosion_pt, 0.1, 0.05, 0, 0);
part_type_scale(explosion_pt, 1, 1.3);
part_type_speed(explosion_pt, 1, 1, 0.01, 0);
part_type_direction(explosion_pt, 0, 360, 0, 0);
part_type_gravity(explosion_pt, 0, 270);
part_type_orientation(explosion_pt, 0, 0, 0, 0, false);
part_type_colour3(explosion_pt, $FFFFFF, $639999, $2BCFFF);
part_type_alpha3(explosion_pt, 1, 1, 0);
part_type_blend(explosion_pt, false);
part_type_life(explosion_pt, 15, 30);
// Explosion particle emitter
explosion_pemit = part_emitter_create(explosion_ps);
part_emitter_region(explosion_ps, explosion_pemit, -8, 8, -8, 8, ps_shape_ellipse, ps_distr_gaussian);
#endregion
#endregion
#region Functions
/// @func change_state(_new_state);
/// @param {Enum.BLOCK_STATE} _new_state The block's new state
/// @desc Changes block's state
change_state = function(_new_state)
{
	state = _new_state;
	visible = true;
	// Change sprite
	switch (state)
	{
		case BLOCK_STATE.EMPTY:
			sprite_index = spr_block_empty;
			if (!draw_empty) visible = false;
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
	if position.xx <= (array_length(parent_grid) - MIN_MATCH)
	{
		for (var i = position.xx + 1; i < array_length(parent_grid); i++)
		{
			var _block = parent_grid[i][position.yy];
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
	if position.yy <= (array_length(parent_grid[0]) - MIN_MATCH)
	{
		for (var i = position.yy + 1; i < array_length(parent_grid[0]); i++)
		{
			var _block = parent_grid[position.xx][i];
			if _block.state == state
			{
				array_push(_matches, _block.position);
			}
			else {break;}
		}
	}
	return _matches;
}

/// @func explode();
/// @desc Blocks explodes and goes back to empty
explode = function(_points)
{
	change_state(BLOCK_STATE.EMPTY);
	part_emitter_burst(explosion_ps, explosion_pemit, explosion_pt, 50);
	audio_play_sound(snd_match, 1, false);
	points_visible = true;
	points = _points;
	alarm[0] = 40;
}
#endregion