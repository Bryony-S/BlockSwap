/// @desc Draw start menu
// Title
draw_set_halign(fa_center);
draw_text_solid_colour(room_width / 2, 10, "BLOCKSWAP", COLOUR_LIGHT_GREY);
#region Title shapes
// Set size & position
var _sprite_scale = 3
var _sprite_scaled_width = sprite_get_width(spr_block_square) * _sprite_scale;
var _block_margin = 10;
var _block_height = 110;
// Draw shapes
draw_sprite_scaled(spr_block_square, (room_width / 2) - ((_block_margin * 1.5) +
	(_sprite_scaled_width * 1.5)), _block_height, _sprite_scale);
draw_sprite_scaled(spr_block_circle, (room_width / 2) - ((_block_margin * 0.5) +
	(_sprite_scaled_width * 0.5)), _block_height, _sprite_scale);
draw_sprite_scaled(spr_block_triangle, (room_width / 2) + ((_block_margin * 0.5) +
	(_sprite_scaled_width * 0.5)), _block_height, _sprite_scale);
draw_sprite_scaled(spr_block_diamond, (room_width / 2) + ((_block_margin * 1.5) +
	(_sprite_scaled_width * 1.5)), _block_height, _sprite_scale);
#endregion