tool
class_name Geometry2D
extends CollisionShape2D

export (Color) var color = Color(1, 1, 1, 1) setget set_color
export var extents := Vector2(32,32) setget set_extents
export var radius := 32 setget set_radius
export var height := 32 setget set_height

func set_color(new_color):
	color = new_color
	update()
	
func set_extents(new_extents):
	if shape is RectangleShape2D:
		shape.extents = new_extents
		extents = new_extents
		update()

func set_radius(new_radius):
	if shape is CircleShape2D or shape is CapsuleShape2D:
		shape.radius = new_radius
		radius = new_radius
		update()

func set_height(new_height):
	if shape is CapsuleShape2D:
		shape.height = new_height
		height = new_height
		update()

func _draw():
	var offset_position = Vector2(0, 0)
	 
	if shape is CircleShape2D:
		draw_circle(offset_position, shape.radius, color)
	elif shape is RectangleShape2D:
		var rect = Rect2(offset_position - shape.extents, shape.extents * 2.0)
		draw_rect(rect, color)
	elif shape is CapsuleShape2D:
		var upper_circle_position = offset_position + Vector2(0, shape.height * 0.5)
		draw_circle(upper_circle_position, shape.radius, color)
		
		var lower_circle_position = offset_position - Vector2(0, shape.height * 0.5)
		draw_circle(lower_circle_position, shape.radius, color)
		
		var rect_position = offset_position - Vector2(shape.radius, shape.height * 0.5)
		var rect = Rect2(rect_position, Vector2(shape.radius * 2, shape.height))
		draw_rect(rect, color)
