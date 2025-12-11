import `libinput`

pub fn part_1(none) i64 {
    removable: i32 = 0
    loop i: i32 = 0 while i < input.lines .. ++i {
        loop j: i32 = 0 while j < input.width .. ++j {
            if input.text[i][j] == '@' {
                count: i32 = 0
                loop i1: i32 = -1 while i1 <= 1 .. ++i1 {
                    loop j1: i32 = -1 while j1 <= 1 .. ++j1 {
                        if ftext_dd(i + i1, j + j1, @input) == '@' {
                            count++
                        }
                    }
                }
                if count < 5 {
                    removable++
                }
            }
        }
    }
    return removable
}

pub fn part_2(none) i64 {
    removable: i32 = 0
    loop go: bool = true while go {
        go = false
        loop i: i32 = 0 while i < input.lines .. ++i {
            loop j: i32 = 0 while j < input.width .. ++j {
                if input.text[i][j] == '@' {
                    count: i32 = 0
                    loop i1: i32 = -1 while i1 <= 1 .. ++i1 {
                        loop j1: i32 = -1 while j1 <= 1 .. ++j1 {
                            if ftext_dd(i + i1, j + j1, @input) == '@' {
                                count++
                            }
                        }
                    }
                    if count < 5 {
                        go = true
                        input.text[i][j] = 'x'
                        removable++
                    }
                }
            }
        }
    }
    return removable
}
