#![no_std]
extern crate alloc;

use alloc::string::String;
use core::fmt::Write as _;

pub fn my_test_func_with_param(buffer: &mut String, value: i32) -> core::fmt::Result {
    write!(buffer, "Iteration {value} was written")
}
