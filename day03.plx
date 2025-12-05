import `libutil`

pub fn part_1(none) i64 {
    sum: i64 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        ch1: char = '0'
        ch2: char = '0'
        val: i32 = 0
        loop j1: i32 = 0 while j1 + 1 < input.width .. ++j1 {
            if input.text[i][j1] > ch1 {
                ch1 = input.text[i][j1]
                ch2 = '0'
                loop j2: i32 = j1 + 1 while j2 < input.width .. ++j2 {
                    if input.text[i][j2] > ch2 {
                        ch2 = input.text[i][j2]
                    }
                }
            }
        }
        sum += 10 * (ch1 - '0') + (ch2 - '0')
    }
    return sum
}

pub fn part_2(none) i64 {
    sum: i64 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        value: i64 = 0
        j: i32 = 0
        loop p: i32 = 0 while p < 12 .. ++p {
            till: i32 = input.width - 11 + p
            max_j: i32 = j
            max: char = input.text[i][j]
            loop j1: i32 = j while j1 < till .. ++j1 {
                if input.text[i][j1] > max {
                    max = input.text[i][j1]
                    max_j = j1
                }
            }
            value = 10 * value + max - '0'
            j = max_j + 1
        }
        sum += value
    }
    return sum
}
