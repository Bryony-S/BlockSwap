/// @desc Draw instructions & animation
draw_self();
// Text
draw_set_font(fnt_main_small);
var _text = @"Use left and right arrow
keys to move clusters";
if (InputDeviceGetAnyGamepadConnected()) _text = @"Use left and right on
D-Pad to move clusters";
draw_text_main(x, y - 50, _text);