extends Node2D

var hovered_item:
	set(value):
		if hovered_item != null and hovered_item.has_method("unhover"): hovered_item.unhover()
		if value != null and value.has_method("hover"): value.hover()
		hovered_item = value

var starting_block_node: BlockNode
var connection_being_created: BlockNodeConnection

enum State {IDLE, MOVING_BLOCK, CREATING_CONNECTION}
var state: State = State.IDLE

func _process(_delta):
	queue_redraw()

func _physics_process(_delta):
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var query_parameters: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query_parameters.position = get_viewport().get_mouse_position()
	query_parameters.collide_with_areas = true
	query_parameters.collide_with_bodies = false
	query_parameters.collision_mask = 2  # mask layer 2
	var results = space_state.intersect_point(query_parameters)

	var item
	for result in results:
		if item == null or result.collider.is_greater_than(item):
			item = result.collider

	if item == null or state == State.IDLE:
		hovered_item = item
	elif state == State.MOVING_BLOCK:
		hovered_item = null
	elif state == State.CREATING_CONNECTION and item is BlockNode and item != starting_block_node:
		hovered_item = item

func _input(event: InputEvent):
	if event.is_action_pressed("select"):
		if hovered_item is Block:
			state = State.MOVING_BLOCK
			hovered_item.select()
		elif hovered_item is BlockNode:
			state = State.CREATING_CONNECTION
			if is_instance_valid(hovered_item.connection): hovered_item.connection.queue_free()
			starting_block_node = hovered_item
			hovered_item = null
			connection_being_created = preload("res://scenes/block_node_connection.tscn").instantiate()
			add_child(connection_being_created)
			connection_being_created.start = starting_block_node
	elif event.is_action_released("select"):
		if state == State.CREATING_CONNECTION:
			if hovered_item != null:
				if is_instance_valid(hovered_item.connection): hovered_item.connection.queue_free()
				connection_being_created.end = hovered_item
			else:
				connection_being_created.queue_free()
		state = State.IDLE
