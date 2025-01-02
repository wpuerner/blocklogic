@tool
class_name OutputBlockNode extends BlockNode

signal data_transmitted(data)

func output(data):
	data_transmitted.emit(data)
