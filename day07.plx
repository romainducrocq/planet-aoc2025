
import `libutil`

pub fn part_1(none) i64 {
    count: i64 = 0
    loop j: i32 = 0 while j < input.width .. ++j {
        if input.text[0][j] == 'S' {
            input.text[1][j] = '|'
            break
        }
    }
    loop i: i32 = 1 while i + 1 < input.lines .. ++i {
        loop j: i32 = 1 while j + 1 < input.width .. ++j {
            if input.text[i][j] == '|' {
                if input.text[i + 1][j] == '^' {
                    count++
                    input.text[i + 1][j - 1] = '|'
                    input.text[i + 1][j + 1] = '|'
                }
                else {
                    input.text[i + 1][j] = '|'
                }
            }
        }
    }
    return count
}

pub fn part_2(none) i64 {
    beams: [200]i64;
    loop j: i32 = 0 while j < input.width .. ++j {
        beams[j] = 0
    }
    loop j: i32 = 0 while j < input.width .. ++j {
        if input.text[0][j] == 'S' {
            beams[j] = 1
            break
        }
    }
    count: i64;
    loop i: i32 = 2 while i < input.lines .. i += 2 {
        next_beams: [200]i64;
        loop j: i32 = 0 while j < input.width .. ++j {
            next_beams[j] = 0
        }
        loop j: i32 = 0 while j < input.width .. ++j {
            if beams[j] > 0 {
                if input.text[i][j] == '^' {
                    next_beams[j - 1] += beams[j]
                    next_beams[j + 1] += beams[j]
                }
                else {
                    next_beams[j] += beams[j]
                }
            }
        }
        loop j: i32 = 0 while j < input.width .. ++j {
            beams[j] = next_beams[j]
        }
        count = 0
        loop j: i32 = 0 while j < input.width .. ++j {
            count += beams[j]
        }
    }
    return count
}
