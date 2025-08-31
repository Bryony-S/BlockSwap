/// @desc Draw instructions & animation
draw_self();
// Text
draw_set_font(fnt_main_small);
var _text = @"Use Z and X to
rotate clusters";
if (InputDeviceGetAnyGamepadConnected()) _text = @"Use A and B to
rotate clusters";
draw_text_main(x, y - 50, _text);