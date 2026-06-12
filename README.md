# __multi3 issue

## Issue 1

Build error: ` Identifier '__multi3' should have been resolved earlier`

```
> cargo +nightly build-bpf
   Compiling upstream-fence v0.1.0 (/Users/b/solana/upstream-fence)
error: linking with `sbpf-linker` failed: exit status: 101
  |
  = note:  "sbpf-linker" "--export-symbols" "/Users/b/solana/upstream-fence/target/bpfel-unknown-none/release/deps/rustcFzNHj9/symbols""<1 object files omitted>" "-L" "/Users/b/solana/upstream-fence/target/bpfel-unknown-none/release/deps/rustcFzNHj9/raw-dylibs" "--cpu" "generic" "-o" "/Users/b/solana/upstream-fence/target/bpfel-unknown-none/release/deps/libupstream_fence.so" "-O3" "--debug" "--llvm-args=--bpf-stack-size=4096" "--dump-module=llvm_dump"
  = note: some arguments are omitted. use `--verbose` to show all linker arguments
  = note: 
          thread 'main' (170623) panicked at /Users/b/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/sbpf-common-0.1.9/src/instruction.rs:147:17:
          internal error: entered unreachable code: Identifier '__multi3' should have been resolved earlier
          note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
          "/Users/b/solana/upstream-fence/target/bpfel-unknown-none/release/deps/libupstream_fence.so"

error: could not compile `upstream-fence` (lib) due to 1 previous error
```

This issue can be fixed by exporting `__multi3` with `"-C", "link-arg=--export=__multi3"` in [config.toml](.cargo/config.toml).

## Issue 2

Runtime error: `Access violation in unknown section at address 0x0 of size 8`

```
> cargo test
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.96s
     Running unittests src/lib.rs (target/debug/deps/upstream_fence-727dfa1842dd6c95)

running 1 test
[2026-06-12T03:59:05.166921000Z DEBUG solana_runtime::message_processor::stable_log] Program 8qbHbw2BbbTHBW1sbeqakYXVKRQM8Ne7pLK7m6CVfeR invoke [1]
[2026-06-12T03:59:05.170929000Z DEBUG solana_runtime::message_processor::stable_log] Program 8qbHbw2BbbTHBW1sbeqakYXVKRQM8Ne7pLK7m6CVfeR consumed 24 of 1400000 compute units
[2026-06-12T03:59:05.171078000Z DEBUG solana_runtime::message_processor::stable_log] Program 8qbHbw2BbbTHBW1sbeqakYXVKRQM8Ne7pLK7m6CVfeR failed: Access violation in unknown section at address 0x0 of size 8
test tests::hello_world ... FAILED

failures:

---- tests::hello_world stdout ----

thread 'tests::hello_world' (178877) panicked at /Users/b/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/mollusk-svm-result-0.7.2/src/check.rs:200:29:
CHECK FAILED: program_result
  Expected: `Success`,
 Got: `UnknownError(ProgramFailedToComplete)`
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace


failures:
    tests::hello_world

test result: FAILED. 0 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.04s

error: test failed, to rerun pass `--lib`
```

Debugging the issue (wrong codegen)

- The disassembled program is at [program.s](program.s)
- On line 21, 0 is moved to r2 (`mov64 r2, 0x0`) 
- Then on line 24, it calls a function (`call fn_00f8`)
- Inside the function on line 41, it tries to load value from r2 (`ldxdw r2, [r2+0x0]`) 
- But since r2 is 0, it fails and causes the error `Access violation in unknown section at address 0x0 of size 8`