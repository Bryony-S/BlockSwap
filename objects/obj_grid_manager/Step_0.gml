/// @desc Cluster movement
// Cluster falls
current_cluster.current_fall_timer--;
if (current_cluster.current_fall_timer <= 0) current_cluster.fall();
// Player moves cluster horizontally
horizontal_movement_timer--;
var _horizontal_movement =
	(InputCheck(INPUT_VERB.MOVE_RIGHT) - InputCheck(INPUT_VERB.MOVE_LEFT));
if (_horizontal_movement != 0) && (horizontal_movement_timer <= 0)
{
	horizontal_movement_timer = horizontal_movement_cooldown;
	current_cluster.move_horizontally(_horizontal_movement);
}
// Player rotates cluster
var _rotate =
	(InputPressed(INPUT_VERB.ROTATE_RIGHT) - InputPressed(INPUT_VERB.ROTATE_LEFT));
if (_rotate != 0) current_cluster.rotate(_rotate);
// Player moves cluster down faster
if (InputPressed(INPUT_VERB.FALL)) current_cluster.fall_faster(true);
if (InputReleased(INPUT_VERB.FALL)) current_cluster.fall_faster(false);