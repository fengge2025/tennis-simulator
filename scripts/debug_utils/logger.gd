class_name Logger extends Node

var logger_name: String


static func initialize(_logger_name: String) -> Logger:
	var logger = Logger.new()
	logger.logger_name = _logger_name
	return logger


func log(args) -> void:
	if logger_name in LoadConfigs.debug_configs.get("logger_domains", []):
		print(args)


func error(args) -> void:
	push_error(args)
