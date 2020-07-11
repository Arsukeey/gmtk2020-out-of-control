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
    for w in height:
        grid.append([])
        grid[w] = []
        for h in width:
            grid[w].append([])
            grid[w][h] = Node.new()
        
    for i in range(3):
        var enemy = Enemy.instance()
        var pos = Vector2(randi() % width, randi() % height)
        enemy.position = Vector2(pos.x * SQR_SIZE, pos.y * SQR_SIZE)
        grid[pos.y][pos.x] = enemy
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
    
func bresenham(start: Vector2, end: Vector2):
    var s = start
    var coordinates = []
    var dx = abs(end.x - start.x)
    var dy = abs(end.y - start.y)
    
    var sx
    var sy
    
    if s.x < end.x:
        sx = 1
    else:
        -1
        
    if s.y < end.y:
        sy = 1
    else:
        -1
        
    var err
    var err2
    if dx > dy:
        err = dx / 2
    else:
        err = -dy / 2
    
    while true:
        coordinates.push_back(start)
        if start.x == end.x and start.y == end.y:
            break
        err2 = err
        if err2 > -dx:
            err -= dy
            s.x += sx
        
        if err2 < dy:
            err += dx
            s.y += sy
    
    return coordinates

func _process(delta):
    $TimerLbl.text = "%.1f" % $TimerSkip.time_left

func _on_Player_turn():
    grid[$Player.position.x / SQR_SIZE][$Player.position.y / SQR_SIZE] = "player"
    print(grid)
    $TimerSkip.wait_time = randf() * 10.0 + 0.4
    $TimerSkip.start()
