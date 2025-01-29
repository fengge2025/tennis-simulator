extends Node
class_name TennisPlayer

enum HitOutcome { MISS, CONT }


class PlayerStat:
	#var miss: int
	#var cont: int
	var weight_dict: Dictionary

	func _init(_miss: int, _cont: int) -> void:
		#miss =  _miss
		#cont = _cont
		weight_dict = {}
		weight_dict[HitOutcome.MISS] = _miss
		weight_dict[HitOutcome.CONT] = _cont


class Player:
	var name: String
	var stat: PlayerStat

	func _init(_name: String, _stat: PlayerStat) -> void:
		name = _name
		stat = _stat

	func hit_ball() -> HitOutcome:
		var outcome = RNG.get_weighted_random(stat.weight_dict)
		return outcome


class RNG:
	static func get_weighted_random(weight_dict: Dictionary) -> HitOutcome:
		randomize()
		var total_weight = 0
		for weight in weight_dict.values():
			total_weight += weight
#
		var random_pick = randi() % total_weight

		var current_sum = 0
		for key in weight_dict.keys():
			current_sum += weight_dict[key]
			if random_pick < current_sum:
				return key

		return weight_dict.keys()[0]
