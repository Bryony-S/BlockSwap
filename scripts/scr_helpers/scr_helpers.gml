/// @func draw_text_main(_x, _y, _text);
/// @param {Real} _x The x position of the text to draw
/// @param {Real} _y The y position of the text to draw
/// @param {String} _text The text to draw
/// @desc Draws text using the game's default text colour (#DEE2E6)
function draw_text_main(_x, _y, _text)
{
	draw_text_solid_colour(_x, _y, _text, COLOUR_WHITE);
}

/// @func draw_text_solid_colour(_x, _y, _text, _colour);
/// @param {Real} _x The x position of the text to draw
/// @param {Real} _y The y position of the text to draw
/// @param {String} _text The text to draw
/// @param {Constant.Colour} _colour The colour the text should be
/// @desc Draws text with a solid colour
function draw_text_solid_colour(_x, _y, _text, _colour)
{
	draw_text_colour(_x, _y, _text, _colour, _colour, _colour, _colour, 1);
}