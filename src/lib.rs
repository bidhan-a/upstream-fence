#![cfg_attr(target_os = "solana", no_std)]

#[cfg(target_arch = "bpf")]
use solana_compiler_builtins as _;

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn entrypoint(input: *mut u8) -> u64 {
    let a = core::ptr::read_volatile(input as *const i64);
    let b = core::ptr::read_volatile(input.add(8) as *const i64);
    a.checked_div(b).unwrap_or(0) as u64 // with u64 instead of i64, it links
}

#[cfg(test)]
mod tests {
    use {
        mollusk_svm::{result::Check, Mollusk},
        solana_instruction::Instruction,
    };

    #[test]
    fn aligned_static_address_is_64_byte_aligned() {
        let program_id = [2u8; 32];

        let mollusk = Mollusk::new(
            &program_id.into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );

        let instruction = Instruction::new_with_bytes(program_id.into(), &[], vec![]);
        mollusk.process_and_validate_instruction(&instruction, &[], &[Check::success()]);
    }
}
