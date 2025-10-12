extends Node

var debug_configs: Dictionary = {}
var match_configs: Dictionary = {}
var debug_configs_loaded: bool = false
var match_configs_loaded: bool = false

func _ready():
	load_debug_config()
	load_match_config()

	if not match_configs_loaded:
		push_error("Match configs not loaded.")

func load_config(file_name: String) -> ConfigFile:
	var config_file = ConfigFile.new()
	var err = config_file.load("res://configs/%s" % file_name)
	if err != OK:
		push_error("Failed to load %s" % file_name)
		return
	return config_file


func load_debug_config() -> void:
	var config_file = load_config("debug.ini")
	if config_file == null:
		return
	
	var logger_domains = config_file.get_value("logger", "logger_domains", [])

	debug_configs = {
		"logger_domains": logger_domains,
	}
	debug_configs_loaded = true

func load_match_config() -> void:
	var config_file = load_config("match.ini")
	if config_file == null:
		return
	
	var territory_x_min = config_file.get_value("territory", "territory_x_min", 0)
	var territory_x_max = config_file.get_value("territory", "territory_x_max", 0)
	var territory_home_y_min = config_file.get_value("territory", "territory_home_y_min", 0)
	var territory_home_y_max = config_file.get_value("territory", "territory_home_y_max", 0)
	var territory_away_y_min = config_file.get_value("territory", "territory_away_y_min", 0)
	var territory_away_y_max = config_file.get_value("territory", "territory_away_y_max", 0)

	var home = MatchConfig.new()
	home.run_x_min = territory_x_min
	home.run_x_max = territory_x_max
	home.run_y_min = territory_home_y_min
	home.run_y_max = territory_home_y_max
	home.hit_x_min = territory_x_min
	home.hit_x_max = territory_x_max
	home.hit_y_min = territory_away_y_min
	home.hit_y_max = territory_away_y_max
	home.loaded = true
	
	var away = MatchConfig.new()
	away.run_x_min = territory_x_min
	away.run_x_max = territory_x_max
	away.run_y_min = territory_away_y_min
	away.run_y_max = territory_away_y_max
	away.hit_x_min = territory_x_min
	away.hit_x_max = territory_x_max
	away.hit_y_min = territory_home_y_min
	away.hit_y_max = territory_home_y_max
	away.loaded = true
	
	match_configs["home"] = home
	match_configs["away"] = away
	match_configs_loaded = true
