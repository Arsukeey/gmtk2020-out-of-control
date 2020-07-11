extends Node2D

const DAMAGE = 15

func attack(grid, ppos, look_dir):
    print("firebeam")
    for i in grid.pos.size():
        match look_dir:
            1, 3:
                if grid.pos[i].y == ppos.y:
                    grid.objs[i].take_damage(DAMAGE)
            2, 4:
                if grid.pos[i].x == ppos.x:
                    grid.objs[i].take_damage(DAMAGE)
