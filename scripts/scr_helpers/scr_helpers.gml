/// @func array_clear(_arr);
/// @param {Array} _arr The array to clear
/// @desc Deletes all values from a 1-dimensional array
function array_clear(_arr)
{
	if (array_length(_arr) > 0) array_delete(_arr, 0, array_length(_arr));
}