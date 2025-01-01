@tool
class_name InputBlockNode extends BlockNode

func connect_output_node(output_node: OutputBlockNode):
	output_node.data_was_sent.connect(_handle_input)
	
func _handle_input(data):
	pass
