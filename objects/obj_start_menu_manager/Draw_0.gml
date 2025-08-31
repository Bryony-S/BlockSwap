/// @desc Draw start menu
// Title
draw_set_font(fnt_title);
draw_text_solid_colour(room_width / 2, 50, "BLOCKSWAP", COLOUR_LIGHT_GREY);
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
#region Menu options
// Options text
draw_set_font(fnt_main_big);
draw_text_main(room_width / 2, 180, "START");
draw_text_main(room_width / 2, 240, "HOW TO PLAY");
draw_text_main(room_width / 2, 300, "CREDITS");
// Cursor
var _cursor_margin = 100;
draw_sprite_stretched(spr_menu_cursor, 0, _cursor_margin, 142 + (menu_select * 60),
	room_width - (_cursor_margin * 2), 80);
#endregion
// Menu controls
draw_set_font(fnt_main_small);
var _controls_text = "Arrow keys to change selection. Z to confirm.";
if (InputDeviceGetAnyGamepadConnected()) _controls_text =
	"D-Pad to change selection. A to confirm.";
draw_text_solid_colour(room_width / 2, room_height - 15, _controls_text,
	COLOUR_LIGHT_GREY);