import "libinput"
use "stdio"
use "stdlib"
use "time"

nr_variants: [6]i32;
pieces: [6][8][3][3]char;
piece_size: [6]i32;

fn fit_region(i: i32) bool {
    s: string = input.text[i]
    w: i32 = parse_num(@s)
    s++
    h: i32 = parse_num(@s)
    s += 2
    sum: i32 = 0
    nr_per_piece: [6]i32;
    loop p: i32 = 0 while p < 6 .. ++p {
        nr_per_piece[p] = parse_num(@s)
        s++
        sum += piece_size[p] * nr_per_piece[p]
    }
    area: i32 = w * h
    empty: i32 = area - sum
    return empty > 0
}

pub fn part_1(none) i64 {
    loop p: i32 = 0 while p < 6 .. ++p {
        piece: [3][3]char;
        loop i: i32 = 0 while i < 3 .. ++i {
            loop j: i32 = 0 while j < 3 .. ++j {
                piece[i][j] = pieces[p][0][i][j] = input.text[1 + 5 * p + i][j]
            }
        }
        nr_variants[p] = 1
        loop f: i32 = 0 while f < 2 .. ++f {
            loop r: i32 = 0 while r < 4 .. ++r {
                h: char = piece[0][0]
                piece[0][0] = piece[0][2]
                piece[0][2] = piece[2][2]
                piece[2][2] = piece[2][0]
                piece[2][0] = h
                h = piece[0][1]
                piece[0][1] = piece[1][2]
                piece[1][2] = piece[2][1]
                piece[2][1] = piece[1][0]
                piece[1][0] = h
                equal: bool = false
                loop v: i32 = 0 while v < nr_variants[p] and not equal .. ++v {
                    equal = true
                    loop i: i32 = 0 while i < 3 and equal .. ++i {
                        loop j: i32 = 0 while j < 3 and equal .. ++j {
                            equal = pieces[p][v][i][j] == piece[i][j]
                        }
                    }
                }
                if not equal {
                    v: i32 = nr_variants[p]
                    loop i: i32 = 0 while i < 3 .. ++i {
                        loop j: i32 = 0 while j < 3 .. ++j {
                            pieces[p][v][i][j] = piece[i][j]
                        }
                    }
                    nr_variants[p]++
                }
            }
            loop i: i32 = 0 while i < 3 .. ++i {
                h: i32 = piece[i][0]
                piece[i][0] = piece[i][2]
                piece[i][2] = h
            }
            piece_size[p] = 0
            loop i: i32 = 0 while i < 3 .. ++i {
                loop j: i32 = 0 while j < 3 .. ++j {
                    if piece[i][j] == '#' {
                        piece_size[p]++
                    }
                }
            }
        }
    }
    nr_fit: i32 = 0
    loop i: i32 = 30 while i < input.lines .. ++i {
        if fit_region(i) {
            nr_fit++
        }
    }
    return nr_fit
}

pub fn part_2(none) i64 {
    rawtime: u64;
    timeinfo: *struc tm = nil
    timebuf: [128]char = $(nil)

    time(@rawtime)
    timeinfo = localtime(@rawtime)
    strftime(timebuf, 80, "%x at %I:%M%p", timeinfo)
    print(fmt3("You saved Christmas on ", timebuf, "!\n"))

    exit(0)
}
