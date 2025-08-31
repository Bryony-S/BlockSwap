/// @desc Player goes back to main menu
if InputPressed(INPUT_VERB.UI_CANCEL)
{
	audio_play_sound(snd_menu_confirm, 1, false);
	player_can_interact = false;
	alarm[0] = CONFIRM_WAIT_TIME;
}