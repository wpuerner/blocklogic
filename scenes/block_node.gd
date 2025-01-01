@tool
class_name BlockNode extends Area2D

@export var is_left_edge: bool:
	set(value):
		is_left_edge = value
		_update_alignment()
@export var label: String:
	set(value):
		label = value
		_update_text()

var connection: BlockNodeConnection

func hover():
	$OutlineSprite2D.show_outline()
	
func unhover():
	$OutlineSprite2D.hide_outline()

func _ready():
	_update_alignment()
	_update_text()

func _update_alignment():
	if !has_node("MarginContainer/Label"): return
	$MarginContainer.set_anchors_and_offsets_preset(Control.LayoutPreset.PRESET_CENTER_LEFT if is_left_edge else Control.LayoutPreset.PRESET_CENTER_RIGHT)
	$MarginContainer/Label.size_flags_horizontal = Control.SizeFlags.SIZE_SHRINK_BEGIN if is_left_edge else Control.SizeFlags.SIZE_SHRINK_END

func _update_text():
	if !has_node("MarginContainer/Label"): return
	$MarginContainer/Label.text = label
