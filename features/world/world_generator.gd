class_name WorldGenerator
extends RefCounted


static func generate(settings: WorldGenerationSetting) -> HexMapData:
	var map := HexMapData.new(settings.height, settings.width)
	return map
