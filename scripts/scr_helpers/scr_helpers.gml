/// @func draw_text_main(_x, _y, _text);
/// @param {Real} _x The x position of the text to draw
/// @param {Real} _y The y position of the text to draw
/// @param {String} _text The text to draw
/// @desc Draws text using the main colour (#DEE2E6)
function draw_text_main(_x, _y, _text)
{
	draw_text_colour(_x, _y, _text, COLOUR_WHITE, COLOUR_WHITE,	COLOUR_WHITE, COLOUR_WHITE, 1);
}