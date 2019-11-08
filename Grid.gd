tool
extends Node2D

"""
Debug grid with cell_size, width, color and sub-divisions options.
"""

export (int) var cell_size = 32 setget _set_cell_size
export (Color) var line_color setget _set_color
export (int) var line_width = 1.0 setget _set_line_width
export (bool) var cell_subdivision = false setget _set_cell_subdivision

var screen_size := Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size

func _draw():
	for i in range(screen_size.y / cell_size):
		draw_line(Vector2(0, i * cell_size), Vector2(screen_size.x, i * cell_size), line_color, line_width)
	for i in range((screen_size.x + cell_size) / cell_size):
		draw_line(Vector2(i * cell_size, 0), Vector2(i * cell_size, screen_size.y), line_color, line_width)
	
	if cell_subdivision:
		for i in range(screen_size.y / (cell_size / 2)):
			draw_line(Vector2(0, i * cell_size), Vector2(screen_size.x, i * cell_size), line_color, line_width * 2)
		for i in range((screen_size.x + cell_size) / (cell_size / 2)):
			draw_line(Vector2(i * cell_size, 0), Vector2(i * cell_size, screen_size.y), line_color, line_width * 2)

func _set_cell_size(value):
	cell_size = value
	update()

func _set_color(value):
	line_color = value
	update()
	
func _set_line_width(value):
	line_width = value
	update()

func _set_cell_subdivision(value):
	cell_subdivision = value
	update()
