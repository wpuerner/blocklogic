class_name BlockNodeConnection extends Node2D

var start: BlockNode:
	set(value):
		start = value
		if is_instance_valid(start): start.connection = self
var end: BlockNode:
	set(value):
		end = value
		if is_instance_valid(end): end.connection = self
		queue_redraw()
var start_position: Vector2
var end_position: Vector2

func _process(_delta):
	if start != null and end == null:
		queue_redraw()
	elif start != null and start.global_position != start_position:
		start_position = start.global_position
		queue_redraw()
	elif end != null and end.global_position != end_position:
		end_position = end.global_position
		queue_redraw()

func _draw():
	if start == null:
		return
	elif start != null and end == null:
		draw_line(start.global_position, get_global_mouse_position(), Color.WHITE, 2.0)
	elif start != null and end != null:
		draw_line(start.global_position, end.global_position, Color.WHEAT, 2.0)

func _should_redraw():
	return (start != null and end == null) or (start != null and start.global_position != start_position) or (end != null and end.global_position != end_position)
