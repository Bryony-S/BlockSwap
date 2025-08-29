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

/// @func draw_sprite_scaled(_sprite, _x, _y, _scale);
/// @param {Asset.GMSprite} _sprite The sprite asset to draw
/// @param {Real} _x The x position of the sprite to draw
/// @param {Real} _y The y position of the sprite to draw
/// @param {Real} _scale How much the sprite should be scaled by
/// @desc Draws a sprite scaled to a specified size
function draw_sprite_scaled(_sprite, _x, _y, _scale)
{
	draw_sprite_ext(_sprite, 0, _x, _y, _scale, _scale, 0, c_white, 1);
}

/// @func normalize_enum(_enum_value, _enum_length);
/// @param {Real} _enum_value The integer value of the enum
/// @param {Real} _enum_length The length of the enum
/// @return {Real} The normalized integer value of the enum
/// @desc Normalizes enum integer values
function normalize_enum(_enum_value, _enum_length)
{
	// Source: https://stackoverflow.com/a/61572168
	var _remainder = _enum_value % _enum_length;
	return (_remainder < 0) ? (_enum_length + _remainder) : _remainder;
}