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

nr_pos: i32;
nr_buttons: i32;
jolting: [100]i64;
min_press: i32;
search_depth: i32;
matrix: [50][50]i64;
reduced_on_pos: [50]i32;
button_presses: [50]i64;

fn search_min_press(jolt: i32, button: i32) none {
    if button < 0 {
        if jolt < min_press {
            min_press = jolt
        }
        return none
    }
    if jolt >= min_press {
        return none
    }
    pos: i32 = reduced_on_pos[button]
    if pos >= 0 {
        value: i64 = jolting[pos]
        loop b: i32 = button + 1 while b < nr_buttons .. ++b {
            value -= matrix[pos][b] * button_presses[b]
        }
        factor: i64 = matrix[pos][button]
        if factor < 0 {
            factor = -factor
            value = -value
        }
        if value < 0 {
            return none
        }
        if factor > 1 {
            if value % factor ~= 0 {
                return none
            }
            value /= factor
        }
        jolt += value
        if jolt < min_press {
            button_presses[button] = value
            search_depth++
            search_min_press(jolt, button - 1)
            search_depth--
        }
    }
    else {
        button_presses[button] = 0
        loop while jolt < min_press {
            search_depth++
            search_min_press(jolt, button - 1)
            search_depth--
            button_presses[button]++
            jolt++
        }
    }
}

pub fn part_2(none) i64 {
    count: i64 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        s: string = input.text[i]
        loop while s[] ~= '(' {
            s++
        }
        nr_pos = (s - input.text[i]) - 3
        nr_buttons = 0
        loop while s[] == '(' {
            loop p: i32 = 0 while p < nr_pos .. ++p {
                matrix[p][nr_buttons] = 0
            }
            s++
            loop {
                num: i64 = parse_num(@s)
                matrix[num][nr_buttons] = 1
                if s++[] == ')' {
                    break
                }
            }
            s++
            nr_buttons++
        }
        loop j: i32 = 0 while s[] ~= '}' .. ++j {
            s++
            jolting[j] = parse_num(@s)
        }
        reduced_rows: [50]i32;
        loop p: i32 = 0 while p < nr_pos .. ++p {
            reduced_rows[p] = 0
        }
        loop b: i32 = 0 while b < nr_buttons .. ++b {
            p: i32 = 0
            loop p = 0 while p < nr_pos .. ++p {
                if not reduced_rows[p] and matrix[p][b] ~= 0 {
                    break
                }
            }
            if p < nr_pos {
                reduced_on_pos[b] = p
                reduced_rows[p] = 1
                factor: i64 = matrix[p][b]
                loop o_p: i32 = 0 while o_p < nr_pos .. ++o_p {
                    if not reduced_rows[o_p] and matrix[o_p][b] ~= 0 {
                        o_factor: i64 = matrix[o_p][b]
                        matrix[o_p][b] = 0
                        loop b2: i32 = b + 1 while b2 < nr_buttons .. ++b2 {
                            matrix[o_p][b2] = factor * matrix[o_p][b2] - o_factor * matrix[p][b2]
                        }
                        jolting[o_p] = factor * jolting[o_p] - o_factor * jolting[p]
                    }
                }
            }
            else {
                reduced_on_pos[b] = -1
            }
        }
        min_press = 1000
        search_min_press(0, nr_buttons - 1)
        count += min_press
    }
    return count
}
