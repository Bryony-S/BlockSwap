/// @desc Player uses menu cursor
if player_can_interact
{
	// Move cursor
	var _menu_selection = InputPressed(INPUT_VERB.UI_DOWN) - InputPressed(INPUT_VERB.UI_UP);
	if (_menu_selection != 0) change_menu_selection(_menu_selection);
	// Select option
	if (InputPressed(INPUT_VERB.UI_CONFIRM)) select_option();
}