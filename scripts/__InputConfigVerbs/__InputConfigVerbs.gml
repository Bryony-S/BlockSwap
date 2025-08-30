function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        FALL,
        MOVE_LEFT,
        MOVE_RIGHT,
        ROTATE_LEFT,
		ROTATE_RIGHT,
		UI_DOWN,
		UI_UP,
		UI_CONFIRM,
		UI_CANCEL
    }
    
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.FALL, "fall", vk_down, gp_padd);
        InputDefineVerb(INPUT_VERB.MOVE_LEFT, "move_left", vk_left, gp_padl);
        InputDefineVerb(INPUT_VERB.MOVE_RIGHT, "move_right", vk_right, gp_padr);
        InputDefineVerb(INPUT_VERB.ROTATE_LEFT, "rotate_left", ord("Z"), gp_face1);
        InputDefineVerb(INPUT_VERB.ROTATE_RIGHT, "rotate_right", ord("X"), gp_face2);
		InputDefineVerb(INPUT_VERB.UI_DOWN, "ui_down", vk_down, gp_padd);
		InputDefineVerb(INPUT_VERB.UI_UP, "ui_up", vk_up, gp_padu);
		InputDefineVerb(INPUT_VERB.UI_CONFIRM, "ui_confirm", ord("Z"), gp_face1);
		InputDefineVerb(INPUT_VERB.UI_CANCEL, "ui_cancel", ord("X"), gp_face2);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.FALL, "fall", undefined, gp_padd);
        InputDefineVerb(INPUT_VERB.MOVE_LEFT, "move_left", undefined, gp_padl);
        InputDefineVerb(INPUT_VERB.MOVE_RIGHT, "move_right", undefined, gp_padr);
        InputDefineVerb(INPUT_VERB.ROTATE_LEFT, "rotate_left", undefined, gp_face2); // !!
        InputDefineVerb(INPUT_VERB.ROTATE_RIGHT, "rotate_right", undefined, gp_face1); // !!
		InputDefineVerb(INPUT_VERB.UI_DOWN, "ui_down", vk_down, gp_padd);
		InputDefineVerb(INPUT_VERB.UI_UP, "ui_up", vk_up, gp_padu);
		InputDefineVerb(INPUT_VERB.UI_CONFIRM, "ui_confirm", ord("Z"), gp_face2); // !!
		InputDefineVerb(INPUT_VERB.UI_CANCEL, "ui_cancel", ord("X"), gp_face1); // !!
    }
}
