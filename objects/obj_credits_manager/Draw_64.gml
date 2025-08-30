/// @desc Draw credits text
// Title
draw_set_font(fnt_main_big);
draw_text_solid_colour(room_width / 2, 20, "CREDITS", COLOUR_LIGHT_GREY);
#region Credits text
draw_set_font(fnt_main_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_main(10, 50, @"Game made in GameMaker by Bryony Stafford
Art made in Aseprite by Bryony Stafford

From OpenGameArt.org:
Completion SFX by Brandon Morris
8-bit Menu SFX by Fupi
Title Theme (8-bit style) music by Kat

8-bit Chiptune Music from OrangeFreeSounds.com
Joystix by Typodermic Fonts from dafont.com
Upheaval by AEnigma from dafont.com
Input plug-in from GitHub.com by
Juju Adams, Alynne Keith and friends");
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
#endregion