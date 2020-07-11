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

signal player_hurt

var enemy_wait = true
const SQR_SIZE = 32
var width = 31
var height = 14

var enemies = {
    pos = [],
    objs = []
}

enum Things {
    Player,
    Enemy,    
}
#var floor_image = preload("res://assets/gridsquare.png")
func reset():
    randomize()
    $Player.position = Vector2((randi() % width) * SQR_SIZE, (randi() % height) * SQR_SIZE)

    for i in range(3):
        var enemy = Enemy.instance()
        var pos = Vector2(randi() % width, randi() % height)
        enemy.position = Vector2(pos.x * SQR_SIZE, pos.y * SQR_SIZE)
        enemies.pos.push_back(pos)
        enemies.objs.push_back(enemy)
        add_child(enemy)
func _ready():
    reset()
        
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
        sx = -1

    if s.y < end.y:
        sy = 1
    else:
        sy = -1
        
    var err
    var err2
    if dx > dy:
        err = dx / 2
    else:
        err = -dy / 2
    
    while true:
        coordinates.push_back(s)

        if s.x == end.x and s.y == end.y:
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
    pass

func _on_Player_turn():
    print("turn")
    if enemy_wait:
        enemy_wait = false
        return
    for i in range(enemies.pos.size()):
        var ppos = Vector2($Player.position.x / SQR_SIZE, $Player.position.y / SQR_SIZE)
        var moves = bresenham(Vector2(enemies.pos[i].x, enemies.pos[i].y), \
            Vector2(ppos.x, ppos.y))
        
        #print("moves[1]: " + str(moves[1]) + " ppos: " + str(ppos))
            
        if moves.size() < 1 or moves[1] == ppos:
            print("Hearts: " + str($Player.hearts))
            #enemies.objs[i].queue_free()
            enemies.objs[i].visible = false
#            enemies.pos.remove(i)
#            enemies.objs.remove(i)
            emit_signal("player_hurt")
            continue
            
        var next_move = moves[1]
        enemies.objs[i].move(Vector2(next_move.x * SQR_SIZE, next_move.y * SQR_SIZE))
        enemies.pos[i] = next_move
    enemy_wait = true

func game_over():
    $GameOverTimer.start()
    enemy_wait = true

    enemies = {
        pos = [],
        objs = []
    }
    
    $GameOverMessage.visible = true


func _on_GameOverTimer_timeout():
    $GameOverMessage.visible = false
    reset()
