@tool
class_name InputBlockNode extends BlockNode

signal input_was_received(data)

func add_connection(new_connection: BlockNodeConnection):
	clear_connections()
	super(new_connection)
	new_connection.data_transmitted.connect(_handle_input)

func get_connection():
	return _get_connections()[0]

func _handle_input(data):
	input_was_received.emit(data)
