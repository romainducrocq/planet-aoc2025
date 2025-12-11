import `libutil`

pub fn part_1(none) i64 {
    sum: i64 = 0
    s: string = input.text[input.lines - 1]
    loop j: i32 = 0 while s[j] == '+' or s[j] == '*' {
        mode: char = s[j]
        result: i64 = ? mode == '+' then 0 else 1
        loop i: i32 = 0 while i < input.lines - 1 .. ++i {
            v: string = @input.text[i][j]
            loop while v[] == ' ' {
                v++
            }
            value: i64 = parse_num(@v)
            if mode == '+' {
                result += value
            }
            else {
                result *= value
            }
        }
        sum += result
        j++
        loop while s[j] == ' ' {
            j++
        }
    }
    return sum
}

pub fn part_2(none) i64 {
    sum: i64 = 0
    s: string = input.text[input.lines - 1]
    loop j: i32 = 0 while s[j] == '+' or s[j] == '*' {
        mode: char = s[j]
        result: i64 = ? mode == '+' then 0 else 1
        loop {
            value: i64 = 0
            digits: bool = false
            loop i: i32 = 0 while i < input.lines - 1 .. ++i {
                if '0' <= input.text[i][j] and input.text[i][j] <= '9' {
                    digits = true
                    value = 10 * value + input.text[i][j] - '0'
                }
            }
            if not digits {
                break
            }
            if mode == '+' {
                result += value
            }
            else {
                result *= value
            }
            j++
        }
        sum += result
        j++
        loop while s[j] == ' ' {
            j++
        }
    }
    return sum
}
