class_name Block extends Area2D

var is_selected: bool
var offset: Vector2

func select():
	offset = position - get_global_mouse_position()
	is_selected = true

func hover():
	$OutlineSprite2D.show_outline()
	
func unhover():
	$OutlineSprite2D.hide_outline()

func _physics_process(_delta):
	if is_selected:
		position = get_global_mouse_position() + offset
		
func _input(event: InputEvent):
	if event.is_action_released("select"):
		is_selected = false
