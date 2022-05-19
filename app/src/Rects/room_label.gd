extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var polygon : PoolVector2Array = get_parent().polygon 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rect_position = (polygon[0]+polygon[2])/2 - rect_size/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
