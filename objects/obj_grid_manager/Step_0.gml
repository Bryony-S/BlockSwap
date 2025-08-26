/// @desc Cluster movement
// Cluster falls
cluster.current_timer--;
if (cluster.current_timer <= 0) cluster.fall();
// Player moves cluster horizontally
var _horizontal_movement =
	(InputPressed(INPUT_VERB.MOVE_RIGHT) - InputPressed(INPUT_VERB.MOVE_LEFT));
if (_horizontal_movement != 0) cluster.move_horizontally(_horizontal_movement);
// Player rotates cluster
var _rotate =
	(InputPressed(INPUT_VERB.ROTATE_RIGHT) - InputPressed(INPUT_VERB.ROTATE_LEFT));
if (_rotate != 0) cluster.rotate(_rotate);
// Player moves cluster down faster
if (InputPressed(INPUT_VERB.FALL)) cluster.fall();