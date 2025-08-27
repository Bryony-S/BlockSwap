/// @desc Cluster movement
// Cluster falls
cluster.current_fall_timer--;
if (cluster.current_fall_timer <= 0) cluster.fall();
// Player moves cluster horizontally
horizontal_movement_timer--;
var _horizontal_movement =
	(InputCheck(INPUT_VERB.MOVE_RIGHT) - InputCheck(INPUT_VERB.MOVE_LEFT));
if (_horizontal_movement != 0) && (horizontal_movement_timer <= 0)
{
	horizontal_movement_timer = horizontal_movement_cooldown;
	cluster.move_horizontally(_horizontal_movement);
}
// Player rotates cluster
var _rotate =
	(InputPressed(INPUT_VERB.ROTATE_RIGHT) - InputPressed(INPUT_VERB.ROTATE_LEFT));
if (_rotate != 0) cluster.rotate(_rotate);
// Player moves cluster down faster
if (InputPressed(INPUT_VERB.FALL)) cluster.fall_faster(true);
if (InputReleased(INPUT_VERB.FALL)) cluster.fall_faster(false);