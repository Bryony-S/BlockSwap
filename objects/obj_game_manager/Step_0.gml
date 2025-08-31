/// @desc Player input
if global.game_over
{
	// Restart game
	if (InputPressed(INPUT_VERB.UI_CONFIRM)) room_restart();
	// Go back to main menu
	if (InputPressed(INPUT_VERB.UI_CANCEL)) room_goto(rm_start_menu);
}



// check if display is larger than the window
if display_get_width()!=window_get_width() {
    // resize window to display
    window_set_size(display_get_width(),display_get_height());
}

