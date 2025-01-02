class_name BlockNodeConnection extends Node2D

signal data_transmitted(data)

var output_node: OutputBlockNode
var input_node: InputBlockNode
var output_node_position: Vector2
var input_node_position: Vector2

func connect_block_node(block_node: BlockNode):
	if block_node is InputBlockNode:
		input_node = block_node
	elif block_node is OutputBlockNode:
		output_node = block_node
		output_node.data_transmitted.connect(_handle_data_transmission)
	block_node.add_connection(self)
	queue_redraw()

func can_connect(block_node: BlockNode):
	if is_instance_valid(output_node):
		return block_node is InputBlockNode and block_node.type == output_node.type
	elif is_instance_valid(input_node):
		return block_node is OutputBlockNode and block_node.type == input_node.type

func _process(_delta):
	if output_node != null and input_node == null:
		queue_redraw()
	elif input_node != null and output_node == null:
		queue_redraw()
	elif output_node != null and output_node.global_position != output_node_position:
		output_node_position = output_node.global_position
		queue_redraw()
	elif input_node != null and input_node.global_position != input_node_position:
		input_node_position = input_node.global_position
		queue_redraw()

func _draw():
	if output_node != null and input_node == null:
		draw_line(output_node.global_position, get_global_mouse_position(), Color.WHITE, 2.0)
	elif input_node != null and output_node == null:
		draw_line(input_node.global_position, get_global_mouse_position(), Color.WHITE, 2.0)
	elif output_node != null and input_node != null:
		draw_line(output_node.global_position, input_node.global_position, Color.WHEAT, 2.0)

func _should_redraw():
	return (output_node != null and input_node == null) or (output_node != null and output_node.global_position != output_node_position) or (input_node != null and input_node.global_position != input_node_position)

func _handle_data_transmission(data):
	data_transmitted.emit(data)
