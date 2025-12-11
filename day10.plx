import `libinput`

pub fn part_1(none) i64 {
    count: i64 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        s: string = input.text[i]
        pattern: i32 = 0
        s++
        loop i: i32 = 1 while s[] ~= ']' .. i *= 2 {
            if s++[] == '#' {
                pattern |= i
            }
        }
        s += 2
        buttons: [100]i32;
        nr_buttons: i32 = 0
        loop while s[] == '(' {
            s++
            buttons[nr_buttons] = 0
            loop {
                num: i64 = parse_num(@s)
                buttons[nr_buttons] |= 1 << num
                if s++[] == ')' {
                    break
                }
            }
            s++
            nr_buttons++
        }
        min: i32 = nr_buttons
        max: i64 = 1 << nr_buttons
        loop m: i32 = 0 while m < max .. ++m {
            nr_switched: i32 = 0
            state: i32 = 0
            loop b: i32 = 0 while b < nr_buttons .. ++b {
                if ((1 << b) & m) ~= 0 {
                    nr_switched++
                    state ^= buttons[b]
                }
            }
            if state == pattern and nr_switched < min {
                min = nr_switched
            }
        }
        count += min
    }
    return count
}

# TODO
pub fn part_2(none) i64 {
    return 1
}
