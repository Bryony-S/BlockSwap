/// @desc Set up start menu
randomise();
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

/// @func select_option();
/// @desc Player selects menu option
select_option = function()
{
	switch (menu_select)
	{
		case START_MENU_OPTIONS.START:
			room_goto(rm_game);
			break;
		case START_MENU_OPTIONS.HOW_TO_PLAY:
			// TBA
			break;
		case START_MENU_OPTIONS.CREDITS:
			// TBA
			break;
	}
}