tool
extends Node2D

"""
Debug grid with cell_size, width, color and sub-divisions options.
"""

export (int) var cell_size = 32 setget _set_cell_size
export (int) var line_thickness = 1.0 setget _set_line_thickness
export (Color) var line_color setget _set_color
export (bool) var cell_subdivision = false setget _set_cell_subdivision
export var subdivision_steps := 4 setget _set_subdivision_steps
export (int) var subdivision_thickness = 2.0 setget _set_subdivision_thickness
export (Color) var subdivision_color setget _set_subdivision_color

var screen_size := Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _draw() -> void:
	for i in range(ceil(screen_size.y / cell_size)):		# Draw vertical lines
		draw_line(Vector2(0, i * cell_size), Vector2(screen_size.x, i * cell_size), line_color, line_thickness)
	for i in range(ceil(screen_size.x / cell_size)):		# Draw horizontal lines
		draw_line(Vector2(i * cell_size, 0), Vector2(i * cell_size, screen_size.y), line_color, line_thickness)
	
	if cell_subdivision:
		var new_cell_size = cell_size * subdivision_steps
		for i in range(ceil(screen_size.y / (cell_size * subdivision_steps))):		# Draw vertical subdivision lines
			draw_line(Vector2(0, i * new_cell_size), Vector2(screen_size.x, i * new_cell_size), subdivision_color, subdivision_thickness)
		for i in range(ceil(screen_size.x / (cell_size * subdivision_steps))):		# Draw horizontal subdivision lines
			draw_line(Vector2(i * new_cell_size, 0), Vector2(i * new_cell_size, screen_size.y), subdivision_color, subdivision_thickness)

func _set_cell_size(value) -> void:
	cell_size = value
	update()

func _set_color(value) -> void:
	line_color = value
	update()
	
func _set_line_thickness(value) -> void:
	line_thickness = value
	update()

func _set_cell_subdivision(value) -> void:
	cell_subdivision = value
	update()

func _set_subdivision_thickness(value) -> void:
	subdivision_thickness = value
	update()

func _set_subdivision_color(value) -> void:
	subdivision_color = value
	update()

func _set_subdivision_steps(value) -> void:
	subdivision_steps = value
	update()
