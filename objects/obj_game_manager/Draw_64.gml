/// @desc Draw game UI
// Score
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_text_main(5, 20, $"Score: {global.player_score}");
// Next cluster preview
draw_set_halign(fa_center);
draw_text_main(200, 150, "Next:");
#region Game over UI
// Game over overlay
if global.game_over
{
	draw_set_alpha(0.95);
	draw_set_colour(COLOUR_DARK_GREY);
	var _overlay_margin = 20;
	draw_rectangle(_overlay_margin, _overlay_margin, room_width - _overlay_margin,
		room_height - _overlay_margin, false);
	draw_set_colour(c_white);
	draw_set_alpha(1);
	// Game over message
	draw_set_font(fnt_main_big);
	draw_text_solid_colour(room_width / 2, 70, "GAME OVER", COLOUR_LIGHT_GREY);
	draw_text_main(room_width / 2, room_height / 2,
		$"FINAL SCORE: {global.player_score}");
	// Instructions
	draw_set_font(fnt_main);
	var _instructions_text = @"Z to restart
X to go back to main menu";
	if (InputDeviceGetAnyGamepadConnected()) _instructions_text = @"A to restart
B to go back to main menu";
	draw_text_solid_colour(room_width / 2, room_height - 70, _instructions_text,
		COLOUR_LIGHT_GREY);
}
#endregion