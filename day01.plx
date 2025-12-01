import `libaoc`

filedata: struc FileData = $(nil)

fn part_1(none) i32 {
    pos: i64 = 50
    count: i32 = 0
    loop i: i32 = 0 while i < filedata.size .. ++i {
        s: string = filedata.buf[i]
        dir: char = s++[]
        clicks: i64 = parse_number(@s)
        if dir == 'R' {
            pos = (pos + clicks) % 100
        }
        else {
            pos -= clicks
            loop while pos < 0 {
                pos += 100
            }
        }
        if pos == 0 {
            count++
        }
    }
    return count
}

fn part_2(none) i32 {
    pos: i64 = 50
    count: i32 = 0
    loop i: i32 = 0 while i < filedata.size .. ++i {
        s: string = filedata.buf[i]
        dir: char = s++[]
        clicks: i64 = parse_number(@s)
        if dir == 'R' {
            loop j: i32 = 0 while j < clicks .. ++j {
                pos++
                if pos == 100 {
                    pos = 0
                    count++
                }
            }
        }
        else {
            loop j: i32 = 0 while j < clicks .. ++j {
                pos--
                if pos == 0 {
                    count++
                }
                if pos < 0 {
                    pos += 100
                }
            }
        }
    }
    return count
}

pub fn main(none) i32 {
    read_file("input/day01.txt", @filedata)
    print_i64(part_1())
    print_i64(part_2())
    close_file(@filedata)
}
