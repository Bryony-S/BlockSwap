/// @desc Resize game when switching to/from fullscreen
if display_get_width() != window_get_width()
	window_set_size(display_get_width(),display_get_height());