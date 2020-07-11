extends Node2D

const DAMAGE = 25

func attack(grid, ppos, look_dir):
    print("icebeam")
    for i in grid.size():
        match look_dir:
            0:
                if ppos.y > grid.pos[i].y and ppos.x == grid.pos[i].x:
                    grid.objs[i].take_damage(DAMAGE)
                    return
            1:
                if ppos.x < grid.pos[i].x and ppos.y == grid.pos[i].y:
                    grid.objs[i].take_damage(DAMAGE)
                    return
            2:
                if ppos.y < grid.pos[i].y and ppos.x == grid.pos[i].x:
                    grid.objs[i].take_damage(DAMAGE)
                    return
            3:
                if ppos.x > grid.pos[i].x and ppos.y == grid.pos[i].y:
                    grid.objs[i].take_damage(DAMAGE)
                    return
