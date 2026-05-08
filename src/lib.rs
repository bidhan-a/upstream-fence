#![cfg_attr(target_arch = "bpf", no_std)]

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[unsafe(no_mangle)]
pub fn entrypoint(_input: *mut u8) -> u64 {
    core::sync::atomic::compiler_fence(core::sync::atomic::Ordering::SeqCst);
    0
}

#[cfg(test)]
mod tests {
    use mollusk_svm::{result::Check, Mollusk};
    use solana_instruction::Instruction;

    #[test]
    pub fn hello_world() {
        let mollusk = Mollusk::new(
            &[2u8; 32].into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );
        mollusk.process_and_validate_instruction(
            &Instruction {
                program_id: [2u8; 32].into(),
                accounts: vec![],
                data: vec![],
            },
            &vec![],
            &[Check::success()],
        );
    }
}
