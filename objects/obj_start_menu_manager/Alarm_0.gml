/// @desc Change rooms
switch (menu_select)
{
	case START_MENU_OPTIONS.START:
		room_goto(rm_game);
		break;
	case START_MENU_OPTIONS.HOW_TO_PLAY:
		// TBA
		break;
	case START_MENU_OPTIONS.CREDITS:
		room_goto(rm_credits);
		break;
}