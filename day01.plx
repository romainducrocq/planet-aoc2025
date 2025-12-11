import `libutil`

pub fn part_1(none) i64 {
    pos: i64 = 50
    password: i32 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        str: string = input.text[i]
        dir: char = str++[]
        clicks: i64 = parse_num(@str)
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
            password++
        }
    }
    return password
}

pub fn part_2(none) i64 {
    pos: i64 = 50
    password: i32 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        str: string = input.text[i]
        dir: char = str++[]
        clicks: i64 = parse_num(@str)
        if dir == 'R' {
            loop j: i32 = 0 while j < clicks .. ++j {
                pos++
                if pos == 100 {
                    pos = 0
                    password++
                }
            }
        }
        else {
            loop j: i32 = 0 while j < clicks .. ++j {
                pos--
                if pos == 0 {
                    password++
                }
                if pos < 0 {
                    pos += 100
                }
            }
        }
    }
    return password
}
