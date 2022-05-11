extends Node2D


onready var map_plane: Node2D = $Map


var start_pos : Vector2 = Vector2.ZERO
var end_pos : Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_pos = get_global_mouse_position()
		if !event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				end_pos = get_global_mouse_position()
				map_plane.add_child(make_line(start_pos, end_pos)) 


func make_line(start: Vector2, end: Vector2) -> Line2D:
	var line : Line2D = Line2D.new()
	line.points = PoolVector2Array([start, end])
	return line
