use std::env;
use std::io::{self, Read};
use colored::*;

fn main() {
    let mut input = read_stdin();

    // skip args[0]
    for arg in env::args().skip(1) {
        // modify input string
        highlight_string(&mut input, &arg);
    }

    // print result
    print!("{}", input);
}

fn highlight_string(s: &mut String, sub: &str) {
    // create a ColoredString
    let highlighted = sub.bold().bright_red();
    // replace the mutable string contents with the highlighted version
    *s = s.replace(sub, &highlighted.to_string());
}

fn read_stdin() -> String {
    let mut buffer = String::new();
    let stdin = io::stdin();
    let mut handle = stdin.lock();

    handle.read_to_string(&mut buffer).unwrap();
    buffer
}
