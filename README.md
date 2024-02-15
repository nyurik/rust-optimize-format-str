# Rust `format!` Optimization Tester

Test for `write!` to optimize the case of a non-formatting string:

```rust
write!(buf, "simple string");
```

There are two cases:  `str` (no formatting args), and `fmt` (a regular formatting string with a param)

To setup compiler, from the Rust repo, run:

```sh
./x.py build --stage 1 library
rustup toolchain link stage1 build/host/stage1
```

Install `cargo asm` tool with `cargo install cargo-show-asm`

Compile compiler+lib in the rust dir with the above commands for the  main branch,
then run this from this test repo to generate `./output/str/main/*` and `./output/fmt/main/*` output files.

```sh
./run.sh main
```

Repeat the process for any other core lib modifications. The checked in output is using 3 cases:

### main
Using ee9c7c940c0 branch

### as_const_str

New function was added:

```rust
 impl<'a> Arguments<'a> {
    /// Same as [`Arguments::as_str`], but will only return `Some(s)` if it can be determined at compile time.
    #[must_use]
    #[inline]
    fn as_const_str(&self) -> Option<&'static str> {
        let s = self.as_str();
        // SAFETY: both cases are valid as the result
        if unsafe { core::intrinsics::is_val_statically_known(s.is_some()) } { s } else { None }
    }
}
```

All `library/core/src/fmt/mod.rs` usages of `write(self, args)` were updated like this:

```rust
fn write_fmt(self, args: Arguments<'_>) -> Result {
    if let Some(s) = args.as_const_str() {
        self.write_str(s)
    } else {
        write(self, args)
    }
}
```

### as_str

A bad attempt to optimize, using the existing `Arguments::as_str` function. Nearly identical to the `as_const_str`, except that it used `as_str`
