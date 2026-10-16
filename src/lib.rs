#![cfg_attr(target_os = "solana", no_std)]

#[cfg(target_arch = "bpf")]
use solana_compiler_builtins as _;

#[cfg(target_os = "solana")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[inline(never)]
unsafe fn repro_ldsx(input: *mut u8) -> u64 {
    let x = core::ptr::read_volatile(input.cast::<i32>());
    x as i64 as u64
}

#[inline(never)]
unsafe fn repro_movsx(input: *mut u8) -> u64 {
    let a = core::ptr::read_volatile(input.cast::<i64>());
    ((a as i32) as i64) as u64
}

#[inline(never)]
unsafe fn repro_gotox(input: *mut u8) -> u64 {
    let idx = core::ptr::read_unaligned(input.cast::<u64>()) % 16;
    let v = core::ptr::read_volatile(input.cast::<u64>());
    match idx {
        0 => v.wrapping_add(0x11),
        1 => v ^ 0x22,
        2 => v.wrapping_mul(3),
        3 => v.rotate_left(4),
        4 => v.wrapping_sub(0x55),
        5 => v | 0x66,
        6 => v & 0x7777,
        7 => v.swap_bytes(),
        8 => v.count_ones() as u64,
        9 => v.reverse_bits(),
        10 => v.wrapping_neg(),
        11 => v.leading_zeros() as u64,
        12 => v.wrapping_shl(5),
        13 => v.wrapping_mul(v),
        14 => v.wrapping_add(v),
        15 => !v,
        _ => 0,
    }
}

#[inline(never)]
unsafe fn repro_bswap(input: *mut u8) -> u64 {
    let x = core::ptr::read_unaligned(input as *const u64);
    x.swap_bytes()
}

#[inline(never)]
unsafe fn repro_storeimm(input: *mut u8) -> u64 {
    core::ptr::write_unaligned(input.add(8) as *mut u64, 42);
    42
}

// Program must be linked with --llvm-args=--gotol-abs-low-bound=0 to generate `gotol`.
#[inline(never)]
unsafe fn repro_gotol(input: *mut u8) -> u64 {
    let x = core::ptr::read_volatile(input.cast::<u64>());
    if x == 0 {
        core::ptr::write_volatile(input.add(24).cast::<u64>(), 1);
    }
    x
}

#[inline(never)]
unsafe fn repro_sdiv(input: *mut u8) -> u64 {
    let a = core::ptr::read_unaligned(input as *const i64);
    let b = core::ptr::read_unaligned(input.add(8) as *const i64);
    a.checked_div(b).unwrap_or(0) as u64
}

#[inline(never)]
unsafe fn repro_atomic(input: *mut u8) -> u64 {
    use core::sync::atomic::{AtomicU64, Ordering};
    (*(&*input.cast::<AtomicU64>())).load(Ordering::Acquire)
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn entrypoint(input: *mut u8, instruction_data: *mut u8) -> u64 {
    let _ = input;
    let data = instruction_data;
    let mut acc: u64 = 0;

    // These work if we pass the appropriate flags.
    acc = acc.wrapping_add(repro_ldsx(data));
    acc = acc.wrapping_add(repro_movsx(data));
    acc = acc.wrapping_add(repro_gotox(data));
    acc = acc.wrapping_add(repro_bswap(data));
    acc = acc.wrapping_add(repro_gotol(data));

    // This doesn't require any flags.
    acc = acc.wrapping_add(repro_storeimm(data));

    // These crash even when we pass the flags, so commenting them out.
    // acc = acc.wrapping_add(repro_sdiv(data));
    // acc = acc.wrapping_add(repro_atomic(data));

    core::ptr::write_volatile(data.add(16).cast::<u64>(), acc);
    0
}

#[cfg(test)]
mod tests {
    use {
        mollusk_svm::{result::Check, Mollusk},
        solana_instruction::Instruction,
    };

    #[test]
    fn test() {
        let mollusk = Mollusk::new(
            &[2u8; 32].into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );
        mollusk.process_and_validate_instruction(
            &Instruction {
                program_id: [2u8; 32].into(),
                accounts: vec![],
                data: vec![0],
            },
            &vec![],
            &[Check::success()],
        );
    }
}
