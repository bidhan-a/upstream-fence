# disable-flags

Program that contains minimal sub-programs to reproduce and check all LLVM `--disable-*` flags.


## --disable-gotox
- Repro: `repro_gotox`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: invalid opcode: 0x0d).`
- With flag: build passes

## --disable-ldsx
- Repro: `repro_ldsx`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: invalid opcode: 0x81).`
- With flag: build passes

## --disable-movsx
- Repro: `repro_movsx`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: mov64 instruction has off: 32, imm: 0 supposed to be zeros)`
- With flag: build passes

## --disable-bswap
- Repro: `repro_bswap`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: invalid opcode: 0xd7).`
- With flag: build passes

## --disable-storeimm
- Repro: `repro_storeimm`
- Flag not needed

## --disable-gotol
- Repro: `repro_gotol` (must be linked with `--llvm-args=--gotol-abs-low-bound=0`)
- `gotol` has no IR pattern, it is emitted for branches whose
  estimated distance exceeds the `--gotol-abs-low-bound` flag (default is
  `INT16_MAX >> 1` or 16383). A realistic repro needs ~16k+ lines of instructions, 
  so we need to set the `gotol-abs-low-bound` flag to 0 just to reproduce it.
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: invalid opcode: 0x06).`
- With flag: build passes

## --disable-sdiv-smod
- Repor: `repro_sdiv`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: div64 instruction has off: 1, imm: 0 supposed to be zeros).`
- With flag: `ERROR llvm: <unknown>:0:0: in function _RNvCs7HLXWsnOovN_14upstream_fence10repro_sdiv i64 (i64, i64): unsupported signed division, please convert to unsigned div/mod.`

## --disable-load-acq-store-rel
- Repro: `repro_atomic`
- Without flag: `Error: Instruction Parse Error. Error detail: (Bytecode error: invalid opcode: 0xdb).`
- With flag: `ERROR fatal error: "Cannot select: 0x7fad5a899350: i64,ch = AtomicLoad<(load acquire (s64) from %ir.0)> 0x7fad59aea8c8, 0x7fad5a899e40\n  0x7fad5a899e40: i64,ch = CopyFromReg 0x7fad59aea8c8, Register:i64 %0\nIn function: _RNvCs7HLXWsnOovN_14upstream_fence12repro_atomic"`

## Summary

1. These flags work correctly
    - `--disable-gotox`
    - `--disable-ldsx`
    - `--disable-movsx`
    - `--disable-bswap`
    - `--disable-gotol`
2. `--disable-storeimm` flag is not needed
3. These flags produce error even when passed
    - `--disable-sdiv-smod`
    - `--disable-load-acq-store-rel`

