import `libaoc`

pub fn part_1(none) i64 {
    sum: i64 = 0
    loop i: i32 = 0 while i < input.size .. ++i {
        ch1: char = '0'
        ch2: char = '0'
        val: i32 = 0
        loop j1: i32 = 0 while j1 + 1 < input.maxlen .. ++j1 {
            if input.text[i][j1] > ch1 {
                ch1 = input.text[i][j1]
                ch2 = '0'
                loop j2: i32 = j1 + 1 while j2 < input.maxlen .. ++j2 {
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

max: [12]char;
num: i64 = 0

fn search(left: i32, i: i32, j: i32) none {
    if left == 0 {
        return none
    }
    pos: char = 12 - left
    till: i32 = input.maxlen - left + 1
    max[pos] = '0'
    loop j1: i32 = j while j1 < till .. ++j1 {
        if input.text[i][j1] > max[pos] {
            max[pos] = input.text[i][j1]
            search(left - 1, i, j1 + 1)
        }
    }
}

pub fn part_2(none) i64 {
    sum: i64 = 0
    loop i: i32 = 0 while i < input.size .. ++i {
        value: i64 = 0
        j: i32 = 0
        loop p: i32 = 0 while p < 12 .. ++p {
            till: i32 = input.maxlen - 11 + p
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
