#![no_std]
extern crate alloc;

use alloc::string::String;
use core::fmt::Write as _;

pub fn my_test_func_with_simple_str(buffer: &mut String) -> core::fmt::Result {
    write!(buffer, "Simple inline string")
}
