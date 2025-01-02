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
@export var type: Type:
	set(value):
		type = value
		$OutlineSprite2D.self_modulate = _get_color_for_type(type)

enum Type {
	BOOL,
	NUMBER,
	OBJECT
}

var _connections: Array[BlockNodeConnection]

func add_connection(new_connection: BlockNodeConnection):
	new_connection.tree_exiting.connect(_handle_connection_exiting_tree.bind(new_connection))
	_connections.append(new_connection)

func has_connection():
	return _connections.size() > 0
	
func clear_connections():
	_connections.clear()

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

func _get_color_for_type(type: Type):
	if type == Type.BOOL: return Color.RED
	if type == Type.NUMBER: return Color.GREEN
	if type == Type.OBJECT: return Color.PURPLE
	return Color.DIM_GRAY

func _get_connections():
	return _connections

func _handle_connection_exiting_tree(connection: BlockNodeConnection):
	_connections.erase(connection)
