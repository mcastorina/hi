use std::io::{self, Read};
use colored::*;

fn main() {
    print!("{}", read_stdin().bold().bright_red());
}

fn read_stdin() -> String {
    let mut buffer = String::new();
    let stdin = io::stdin();
    let mut handle = stdin.lock();

    handle.read_to_string(&mut buffer).unwrap();
    buffer
}
