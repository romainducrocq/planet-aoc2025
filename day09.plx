import `libutil`
use `stdlib`

type struc redtile_t(x: i64, y: i64)
type struc area_t(redtile1: i32, redtile2: i32, area: i64)

redtiles: [1000]struc redtile_t;
areas: [499500]struc area_t;

pub fn qsort_compare(a: *any, b: *any) i32 {
    a_area: *struc area_t = cast<*struc area_t>(a)
    b_area: *struc area_t = cast<*struc area_t>(b)
    return ? b_area[].area < a_area[].area then -1 else (
        ? b_area[].area > a_area[].area then 1 else 0)
}

pub fn part_1(none) i64 {
    loop i: i32 = 0 while i < input.lines .. ++i {
        s: string = input.text[i]
        redtiles[i].x = parse_number(@s)
        s++
        redtiles[i].y = parse_number(@s)
    }
    nr_area: i32 = 0
    loop i: i32 = 1 while i < input.lines .. ++i {
        loop j: i32 = 0 while j < i .. j++ {
            areas[nr_area].redtile1 = i
            areas[nr_area].redtile2 = j
            dx: i64 = redtiles[i].x - redtiles[j].x
            if dx < 0 {
                dx = -dx
            }
            dy: i64 = redtiles[i].y - redtiles[j].y
            if dy < 0 {
                dy = -dy
            }
            areas[nr_area].area = (dx + 1) * (dy + 1)
            nr_area++
        }
    }
    qsort_f(areas, nr_area, sizeof(areas[0]))
    return areas[0].area
}

pub fn part_2(none) i64 {
    nr_areas: i32 = input.lines * (input.lines - 1) / 2
    loop a: i32 = 0 while a < nr_areas .. ++a {
        t1: i32 = areas[a].redtile1
        x1: i64 = redtiles[t1].x
        y1: i64 = redtiles[t1].y
        t2: i32 = areas[a].redtile2
        x2: i64 = redtiles[t2].x
        y2: i64 = redtiles[t2].y
        if x1 > x2 {
            h: i64 = x1
            x1 = x2
            x2 = h
        }
        if y1 > y2 {
            h: i64 = y1
            y1 = y2
            y2 = h
        }
        next: bool = true
        loop i: i32 = 0 while i < input.lines and next .. ++i {
            if x1 < redtiles[i].x and redtiles[i].x < x2 and y1 < redtiles[i].y and redtiles[i].y < y2 {
                next = false
            }
        }
        loop i1: i32 = 0 while i1 < input.lines and next .. ++i1 {
            i2: i32 = (i1 + 1) % input.lines
            xl1: i64 = redtiles[i1].x
            yl1: i64 = redtiles[i1].y
            xl2: i64 = redtiles[i2].x
            yl2: i64 = redtiles[i2].y
            if yl1 > yl2 {
                h: i64 = yl1
                yl1 = yl2
                yl2 = h
            }
            if xl1 > xl2 {
                h: i64 = xl1
                xl1 = xl2
                xl2 = h
            }
            if xl1 == xl2 and x1 < xl1 and xl1 < x2 {
                if yl1 <= y1 and y2 <= yl2 {
                    next = false
                }
            }
            if yl1 == yl2 and y1 < yl1 and yl1 < y2 {
                if xl1 <= x1 and x2 <= xl2 {
                    next = false
                }
            }
        }
        if next {
            return areas[a].area
        }
    }
    return 0
}
