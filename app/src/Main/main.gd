extends Node2D


onready var map_plane: Node2D = $Map


var start_pos : Vector2 = Vector2.ZERO
var end_pos : Vector2 = Vector2.ZERO
var rect_scene : PackedScene = preload("res://src/Rects/rect_bg.tscn")
onready var rect_color : Color = $CanvasLayer/Sidebar/Editor/Color/ColorPickerButton.color


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_pos = get_global_mouse_position()
		if !event.is_pressed() and $CanvasLayer/Sidebar/Editor.visible:
			if event.button_index == BUTTON_LEFT:
				end_pos = get_global_mouse_position()
				map_plane.add_child(make_rect(start_pos, end_pos)) 


func make_line(start: Vector2, end: Vector2) -> Line2D:
	var line : Line2D = Line2D.new()
	line.points = PoolVector2Array([start, end])
	return line


func make_rect(start: Vector2, end: Vector2) -> Polygon2D:
	var rect : Polygon2D = rect_scene.instance()
	rect.color = rect_color
	rect.polygon = PoolVector2Array([start, Vector2(start.x, end.y), end, Vector2(end.x, start.y)])
	return rect


func _on_RectTypes_item_selected(index: int) -> void:
	match index:
		0:
			rect_scene = preload("res://src/Rects/rect_bg.tscn")
		1:
			rect_scene = preload("res://src/Rects/rect_rm.tscn")


func _on_ColorPickerButton_color_changed(color: Color) -> void:
	rect_color = color
