extends Node2D

const DAMAGE = 30
const RANGE = 3

func attack(grid, ppos, look_dir):
    for i in grid.size():
        match look_dir:
            0:
                if grid.pos[i].x == ppos.x and ppos.y - grid.pos[i].y <= RANGE:
                    grid.objs[i].take_damage(DAMAGE)
            1:
                if grid.pos[i].y == ppos.y and grid.pos[i].x - ppos.x <= RANGE:
                    grid.objs[i].take_damage(DAMAGE)
            2:
                if grid.pos[i].x == ppos.x and grid.pos[i].y - ppos.y <= RANGE:
                    grid.objs[i].take_damage(DAMAGE)
            3:
                if grid.pos[i].y == ppos.y and ppos.x - grid.pos[i].x <= RANGE:
                    grid.objs[i].take_damage(DAMAGE)
