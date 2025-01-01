@tool
class_name OutputBlockNode extends BlockNode

signal data_was_output(data)

func output(data):
	data_was_output.emit(data)
