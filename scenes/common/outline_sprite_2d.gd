extends Sprite2D

func show_outline():
	material.set_shader_parameter("width", 2)
	
func hide_outline():
	material.set_shader_parameter("width", 0)
