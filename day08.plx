import `libutil`
use `stdlib`

type struc dist_t(box1: i32, box2: i32, dist_sq: i64)
type struc box_t(x: i64, y: i64, z: i64, circuit: i32)

dists: [499500]struc dist_t;
boxes: [1000]struc box_t;

compare_int: i32 = 1
compare_dist: i32 = 2
compare: i32 = 0
pub fn qsort_compare(a: *any, b: *any) i32 {
    match compare {
        -> 1 { # compare_int
            return (cast<*i32>(b)[] - cast<*i32>(a)[])
        }
        -> 2 { # compare_dist
            a_dist: *struc dist_t = cast<*struc dist_t>(a)
            b_dist: *struc dist_t = cast<*struc dist_t>(b)
            return ? b_dist[].dist_sq < a_dist[].dist_sq then 1 else (
                ? b_dist[].dist_sq > a_dist[].dist_sq then -1 else 0)
        }
        otherwise {
            return -1
        }
    }
}

pub fn part_1(none) i64 {
    loop i: i32 = 0 while i < input.lines .. ++i {
        s: *char = input.text[i]
        boxes[i].x = parse_number(@s)
        s++
        boxes[i].y = parse_number(@s)
        s++
        boxes[i].z = parse_number(@s)
        boxes[i].circuit = i
    }
    nr_dist: i32 = 0
    loop i: i32 = 1 while i < input.lines .. ++i {
        loop j: i32 = 0 while j < i .. ++j {
            dists[nr_dist].box1 = i
            dists[nr_dist].box2 = j
            dx: i64 = boxes[i].x - boxes[j].x
            dy: i64 = boxes[i].y - boxes[j].y
            dz: i64 = boxes[i].z - boxes[j].z
            dists[nr_dist].dist_sq = dx * dx + dy * dy + dz * dz
            nr_dist++
        }
    }
    compare = compare_dist
    qsort_f(dists, nr_dist, sizeof(dists[0]))
    loop i: i32 = 0 while i < input.lines .. ++i {
        circuit1: i32 = boxes[dists[i].box1].circuit
        circuit2: i32 = boxes[dists[i].box2].circuit
        if circuit2 < circuit1 {
            h: i32 = circuit1
            circuit1 = circuit2
            circuit2 = h
        }
        loop j: i32 = 0 while j < input.lines .. ++j {
            if boxes[j].circuit == circuit2 {
                boxes[j].circuit = circuit1
            }
        }
    }
    circuit_sizes: [1000]i32;
    loop i: i32 = 0 while i < input.lines .. ++i {
        circuit_sizes[i] = 0
    }
    loop i: i32 = 0 while i < input.lines .. ++i {
        circuit_sizes[boxes[i].circuit]++
    }
    compare = compare_int
    qsort_f(circuit_sizes, input.lines, sizeof(circuit_sizes[0]))
    answer: i64 = 1
    loop i: i32 = 0 while i < 3 .. ++i {
        answer *= circuit_sizes[i]
    }
    return answer
}

pub fn part_2(none) i64 {
    answer: i64 = 0
    loop i: i32 = 0 while i < input.lines * (input.lines - 1) / 2 .. ++i {
        circuit1: i32 = boxes[dists[i].box1].circuit
        circuit2: i32 = boxes[dists[i].box2].circuit
        if circuit1 ~= circuit2 {
            if circuit2 < circuit1 {
                h: i32 = circuit1
                circuit1 = circuit2
                circuit2 = h
            }
            loop j: i32 = 0 while j < input.lines .. ++j {
                if boxes[j].circuit == circuit2 {
                    boxes[j].circuit = circuit1
                }
            }
            answer = boxes[dists[i].box1].x * boxes[dists[i].box2].x
        }
    }
    return answer
}
