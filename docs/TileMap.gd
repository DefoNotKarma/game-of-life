extends TileMap

const tilesize = 64

var is_paused = true
var wait = false

var temp_field = []

onready var camera = $Camera2D
onready var pauseicon = $Camera2D/Control/pause
onready var playicon = $Camera2D/Control/play

func _ready() -> void:
	for x in range(-19,36):
		var temp = []
		for y in range(-10,21):
			set_cell(x,y,0)
			temp.append(0)
		temp_field.append(temp)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var pos = (get_local_mouse_position()/tilesize).floor()
		set_cellv(pos, 1-get_cellv(pos))
		
	if event.is_action_pressed("play"):
		is_paused = !is_paused
	
	if event.is_action_pressed('clear'):
		is_paused = true
		for x in range(-19,36):
			for y in range(-10,21):
				set_cell(x,y,0)

func _physics_process(delta: float) -> void:
	update()
	if is_paused:
		playicon.visible = false
		pauseicon.visible = true
	else:
		pauseicon.visible = false
		playicon.visible = true

func update():
	if is_paused:
		return
	
	for x in range(-19,36):
		for y in range(-10,21):
			var living = 0 
			for x_near in [-1,0,1]:
				for y_near in [-1,0,1]:
					if x == 0 and y == 0:
						if get_cell(x+x_near,y+y_near) == 1:
							living += 1
			if get_cell(x,y) == 1:
				if living == 2 or living == 3:
					set_cell(x,y,1)
				else:
					set_cell(x,y,0)
			else:
				if living == 3:
					set_cell(x,y,1)
				else:
					set_cell(x,y,0)
					
	for x in range(-19,36):
		for y in range(-10,21):
			set_cell(x,y,temp_field[x][y])


