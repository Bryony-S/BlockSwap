/// @desc Draw instructions
// Title
draw_set_font(fnt_main_big);
draw_text_solid_colour(room_width / 2, 20, "HOW TO PLAY", COLOUR_LIGHT_GREY);
#region Gameplay explanation
draw_set_font(fnt_main_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(COLOUR_WHITE);
draw_text_ext(10, 60,
"Clusters of blocks will fall from the top of the grid. Arrange blocks of the same shape/colour in rows or columns of three or more to gain points and clear those blocks from the grid. If the grid fills up to the top, game over!",
-1, room_width - 10);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
#endregion
#region Fall faster text
var _fall_text = @"Use the down arrow key to
make the cluster fall faster";
if (InputDeviceGetAnyGamepadConnected()) _fall_text =
	@"Use down on D-Pad to
make the cluster fall faster";
draw_text_main(room_width / 2, room_height - 50, _fall_text);
#endregion
// Back to main menu text
var _menu_text = "X to go back to main menu";
if (InputDeviceGetAnyGamepadConnected()) _menu_text = "B to go back to main menu";
draw_text_solid_colour(room_width / 2, room_height - 15, _menu_text, COLOUR_LIGHT_GREY);