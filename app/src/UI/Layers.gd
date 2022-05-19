extends Tree


func _ready() -> void:
	var _err: = connect("item_selected", self, "_on_tree_item_selected")
	_err = connect("item_edited", self, "_on_tree_item_edited")


# This draws the tree from a data structure provided ("model")
func update_tree(map_plane: Node2D):
	
	var layers: = map_plane.get_children()
	
	var model: = {}
	for layer in layers:
		model[layer.name] = layer

	clear()

	# Create the root TreeItem ("model")
	var item_model: = create_item()

	# Set the text label for this item (the 0 specifies the Tree column)
	item_model.set_text(0, map_plane.name) 

	# Set the actual model node as the TreeItem's metadata.
	# This means I can get the actual model node from the TreeItem using tree_item.get_metadata(0)
	item_model.set_metadata(0, map_plane) 

	# Create a subheading / child TreeItem ("bodies")
	var item_bodies: = create_item(item_model)
	item_bodies.set_text(0, "Bodies")
	item_bodies.set_selectable(0, false)

	# Few lines to sort all the bodies in the model into alphabetical order and add them to the tree as children to the Bodies subheading
	var bodies_array = []
	for body_name in model.keys():
		bodies_array.append(body_name)
		bodies_array.sort()
	if !bodies_array.empty():
		for body_name in bodies_array:
			create_tree_item(model[body_name], item_bodies)


# Sub function to create a TreeItem for a body or joint (_item)
# Creates a selectable text label in column 0 and a check box in column 1
func create_tree_item(_item, _parent_item):
	var item = create_item(_parent_item)
	item.set_text(0, _item.name)
	item.set_metadata(0, _item)
	item.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
	item.set_checked(1, _item.visible)
	item.set_tooltip(1, "Show/Hide")
	item.set_editable(1, true)
	item.set_tooltip(0, "this shows when you mouse hover over the item")


# item selected (if the TreeItem is set to selectable, clicking it will fire this signal)
func _on_tree_item_selected():
	# Get the node from the selected tree_item
	if get_selected().get_metadata(0) == null:
		return
	var selected_node = get_selected().get_metadata(0)
	selected_node._on_selected() # Do something with it


# Name change (if the TreeItem is set to editable, clicking it lets you change the TreeItem's label)
# Here we use the updated label to change the name of the node represented by the tree_item
func _on_tree_item_edited():
	if get_edited_column() == 0:
		if get_edited().get_metadata(0) == null:
			return
		var edited_node = get_edited().get_metadata(0)
		var new_name = get_edited().get_text(0)
		edited_node.name = new_name


static func get_layers(map_plane: Node2D) -> Array:
	var layers = map_plane.get_children()
	return layers


func update_list(map_plane: Node2D) -> void:
	for item in get_layers(map_plane):
		var layer: = create_item(item)
		layer.set_text(0, item.name)
