class_name Logger extends Node

var logger_name: String


static func initialize(_logger_name: String) -> Logger:
	var logger: Logger = Logger.new()
	logger.logger_name = _logger_name
	return logger


func log(args: String) -> void:
	if logger_name in LoadConfigs.debug_configs.get("logger_domains", []):
		print(args)


func error(args: String) -> void:
	push_error(args)
