/// @desc Set up start menu
randomise();
audio_play_sound(snd_menu_music, 0.9, true);
// Text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
// Menu options
enum START_MENU_OPTIONS
{
	START = 0,
	HOW_TO_PLAY = 1,
	CREDITS = 2
}
menu_select = START_MENU_OPTIONS.START;
options_length = 3;
player_can_interact = true;

/// @func select_option();
/// @desc Player selects menu option
select_option = function()
{
	audio_play_sound(snd_menu_confirm, 1, false);
	player_can_interact = false;
	alarm[0] = 40;
}

/// @func change_menu_selection(_selection_change);
/// @param {Real} _selection_change The change in value of the selection
/// @desc Changes the currently selected menu option
change_menu_selection = function(_selection_change)
{
	audio_play_sound(snd_menu_select, 1, false);
	menu_select = normalize_enum(menu_select + _selection_change, options_length);
}