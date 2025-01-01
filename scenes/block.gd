@tool
class_name Block extends Area2D

@export var width: int:
	set(value):
		width = value
		_update_children()
@export var height: int:
	set(value):
		height = value
		_update_children()
@export var label: String:
	set(value):
		label = value
		_update_children()

var is_selected: bool
var offset: Vector2

func select():
	offset = position - get_global_mouse_position()
	is_selected = true

func hover():
	var stylebox: StyleBox = $Panel.get_theme_stylebox("panel")
	stylebox.border_color.a = 1.0
	$Panel.add_theme_stylebox_override("panel", stylebox)
	
func unhover():
	var stylebox: StyleBox = $Panel.get_theme_stylebox("panel")
	stylebox.border_color.a = 0.0
	$Panel.add_theme_stylebox_override("panel", stylebox)

func _ready():
	_update_children()

func _physics_process(_delta):
	if is_selected:
		position = get_global_mouse_position() + offset
		
func _input(event: InputEvent):
	if event.is_action_released("select"):
		is_selected = false

func _update_children():
	if !has_node("Panel/Label"): return
	$Panel.size.x = width
	$Panel.size.y = height
	$Panel/Label.text = label
	$CollisionShape2D.shape.size = $Panel.size
	$CollisionShape2D.position = $CollisionShape2D.shape.size / 2
