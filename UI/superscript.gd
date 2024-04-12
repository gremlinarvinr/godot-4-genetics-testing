@tool
extends RichTextEffect
class_name RichTextSuperscript

var bbcode = "sup"

func _process_custom_fx(char_fx):
	char_fx.transform = char_fx.transform.scaled_local(Vector2(.7,.7))
	char_fx.offset = Vector2(0, char_fx.env.offset_y if char_fx.env.has("offset_y") else -5)
	return true
