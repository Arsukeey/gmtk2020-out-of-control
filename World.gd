extends Node2D

export (PackedScene) var Enemy

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

const SQR_SIZE = 32
var width = 30
var height = 20

enum Things {
    Player,
    Enemy,    
}
var grid = []
#var floor_image = preload("res://assets/gridsquare.png")

func _ready():
    randomize()
    $Player.position = Vector2((randi() % width) * SQR_SIZE, (randi() % height) * SQR_SIZE)
    
    # instantiate grid
    for w in width:
        grid.append([])
        grid[w] = []
        for h in height:
            grid[w].append([])
            grid[w][h] = 0
        
    for i in range(3):
        var enemy = Enemy.instance()
        var pos = Vector2(randi() % width, randi() % height)
        enemy.position = Vector2(pos.x * SQR_SIZE, pos.y * SQR_SIZE)
        grid[pos.x][pos.y] = enemy
        add_child(enemy)
        
#    for i in range(width):
#        for j in range(height):
#            var instance_floor = Position2D.new()
#            instance_floor.position = Vector2(i * SQR_SIZE, j * SQR_SIZE)
#            print(instance_floor.position)
#            var floor_sprite = Sprite.new()
#            floor_sprite.texture = floor_image
#            instance_floor.add_child(floor_sprite)
#            add_child(instance_floor)
    
func _process(delta):
    $TimerLbl.text = "%.1f" % $TimerSkip.time_left

func _on_Player_turn():
    grid[$Player.position.x / SQR_SIZE][$Player.position.y / SQR_SIZE] = "player"
    print(grid)
    $TimerSkip.wait_time = randf() * 10.0 + 0.4
    $TimerSkip.start()
