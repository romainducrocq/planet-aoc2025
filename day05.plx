import `libutil`

pub fn part_1(none) i64 {
    i: i32 = 0
    loop while input.text[i][0] ~= nil {
        i++
    }
    count: i32 = 0
    loop i++ while i < input.lines .. ++i {
        line: *char = input.text[i]
        id: i64 = parse_number(@line)
        loop i1: i32 = 0 while input.text[i1][0] ~= nil .. ++i1 {
            line = input.text[i1]
            from: i64 = parse_number(@line)
            line++
            to: i64 = parse_number(@line)
            if from <= id and id <= to {
                count++
                break
            }
        }
    }
    return count
}

type struc range_t(from: i64, to: i64, next: *struc range_t)

fn add_range(ref_ranges: **struc range_t, from: i64, to: i64) none {
    loop while ref_ranges[] ~= nil and ref_ranges[][].to < from {
        ref_ranges = @ref_ranges[][].next
    }
    if ref_ranges[] == nil or to < ref_ranges[][].from {
        new_range: *struc range_t = cast<*struc range_t>(malloc(sizeof<struc range_t>))
        new_range[].from = from
        new_range[].to = to
        new_range[].next = ref_ranges[]
        ref_ranges[] = new_range
        return none
    }
    if ref_ranges[][].from < from {
        from = ref_ranges[][].from
    }
    loop while ref_ranges[][].next ~= nil and ref_ranges[][].next[].from <= to {
        ref_ranges[] = ref_ranges[][].next
    }
    ref_ranges[][].from = from
    if ref_ranges[][].to < to {
        ref_ranges[][].to = to
    }
}

pub fn part_2(none) i64 {
    ranges: *struc range_t = nil
    loop i: i32 = 0 while input.text[i][0] ~= nil .. ++i {
        line: *char = input.text[i]
        from: i64 = parse_number(@line)
        line++
        to: i64 = parse_number(@line)
        add_range(@ranges, from, to)
    }
    count: i64 = 0
    loop next_range: *struc range_t = ranges while next_range ~= nil {
        count += next_range[].to - next_range[].from + 1
        prev_range: *struc range_t = next_range
        next_range = next_range[].next
        free(prev_range)
    }
    return count
}
