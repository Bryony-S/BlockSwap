/// @desc Player input
if global.game_over
{
	// Restart game
	if (InputPressed(INPUT_VERB.UI_CONFIRM)) room_restart();
	// Go back to main menu
	if (InputPressed(INPUT_VERB.UI_CANCEL)) room_goto(rm_start_menu);
}