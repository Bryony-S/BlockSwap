/// @desc Display points
draw_self();
if points_visible
{
	draw_set_font(fnt_points);
	draw_text_main(x, y, points);
}