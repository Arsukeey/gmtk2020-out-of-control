extends Node2D


# Out of Control

# As ever, how you interpret that is entirely up to you. 
# A mountain bike with no  breaks is out of control. 
# A game where the rules change every turn is out of control. 
# A virus that can leap from host to host is out of control. 
# The GMTK jam is about design, innovation, and creativity, so we're looking 
# for games that run with this idea, games that make us smile, laugh, think and yell with frustration. 
# Take something players usually have control of, and sever that tie. 
# Take something that developers usually have control of 
# and see what happens when you're no longer in charge.

const SQR_SIZE = 64
export var width = 30
export var height = 20

#var floor_image = preload("res://assets/gridsquare.png")

func _ready():
    randomize()
#    for i in range(width):
#        for j in range(height):
#            var instance_floor = Position2D.new()
#            instance_floor.position = Vector2(i * SQR_SIZE, j * SQR_SIZE)
#            print(instance_floor.position)
#            var floor_sprite = Sprite.new()
#            floor_sprite.texture = floor_image
#            instance_floor.add_child(floor_sprite)
#            add_child(instance_floor)

func _on_Player_turn():
    $TimerSkip.wait_time = randf() * 5.0
    $TimerSkip.start()
