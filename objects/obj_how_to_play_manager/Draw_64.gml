/// @desc Draw instructions
// Title
draw_set_font(fnt_main_big);
draw_text_solid_colour(room_width / 2, 20, "HOW TO PLAY", COLOUR_LIGHT_GREY);
// Gameplay explanation
draw_set_font(fnt_main_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(COLOUR_WHITE);
draw_text_ext(10, 60,
"Clusters of blocks will fall from the top of the grid. Arrange blocks of the same shape/colour in rows or columns of three or more to gain points and clear those blocks from the grid. If the grid fills up to the top, game over!",
-1, (room_width / 3) * 2);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);