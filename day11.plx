import "libinput"
use "stdio"
use "stdlib"
use "string"

type struc out_t;
type struc node_t(name: [4]char, outs: *struc out_t, paths: i64, next: *struc node_t)
type struc out_t(node: *struc node_t, next: *struc out_t)

all_nodes: *struc node_t = nil
to_node: *struc node_t = nil

fn add_node(s: string) *struc node_t {
    loop node: *struc node_t = all_nodes while node ~= nil .. node = node[].next {
        if strncmp(node[].name, s, 3) == 0 {
            return node
        }
    }
    new_node: *struc node_t = cast<*struc node_t>(malloc(sizeof<struc node_t>))
    strncpy(new_node[].name, s, 3)
    new_node[].name[3] = nil
    new_node[].outs = nil
    new_node[].paths = -1
    new_node[].next = all_nodes
    all_nodes = new_node
    return new_node
}

fn calc_paths(node: *struc node_t) i64 {
    if node[].paths >= 0 {
        return node[].paths
    }
    if node == to_node {
        node[].paths = 1
        return 1
    }
    if node[].paths == -2 {
        perror("Cyclic graph\n")
        abort()
    }
    node[].paths = -2
    paths: i64 = 0
    loop out: *struc out_t = node[].outs while out ~= nil .. out = out[].next {
        paths += calc_paths(out[].node)
    }
    node[].paths = paths
    return paths
}

pub fn part_1(none) i64 {
    loop i: i32 = 0 while i < input.lines .. ++i {
        s: string = input.text[i]
        node: *struc node_t = add_node(s)
        s += 4
        loop while s[] == ' ' {
            s++
            new_out: *struc out_t = cast<*struc out_t>(malloc(sizeof<struc out_t>))
            new_out[].node = add_node(s)
            new_out[].next = node[].outs
            node[].outs = new_out
            s += 3
        }
    }
    to_node = add_node("out")
    answer: i64 = calc_paths(add_node("you"))
    return answer
}

pub fn part_2(none) i64 {
    to_node = add_node("out")
    answer: i64 = calc_paths(add_node("dac"))
    loop node: *struc node_t = all_nodes while node ~= nil .. node = node[].next {
        node[].paths = -1
    }
    to_node = add_node("dac")
    answer *= calc_paths(add_node("fft"))
    loop node: *struc node_t = all_nodes while node ~= nil .. node = node[].next {
        node[].paths = -1
    }
    to_node = add_node("fft")
    answer *= calc_paths(add_node("svr"))
    return answer
}
