extends Node2D

var hp = 100

func _ready():
    $HP.value = 100

func _process(delta):
    $HP.value = hp
    if hp > 35:
        $HP.texture_progress = preload("res://assets/lifebar_fill_green.png")
    else:
        $HP.texture_progress = preload("res://assets/lifebar_fill_red.png")
    if hp <= 0:
        visible = false
        #queue_free()

func move(pos):
    position = pos

func take_damage(dmg):
    hp -= dmg
