/// @desc Player uses menu cursor
// Move cursor
if (InputPressed(INPUT_VERB.UI_DOWN))
	menu_select = normalize_enum(menu_select + 1, options_length);
if (InputPressed(INPUT_VERB.UI_UP))
	menu_select = normalize_enum(menu_select - 1, options_length);
// Select option
if (InputPressed(INPUT_VERB.UI_CONFIRM)) select_option();