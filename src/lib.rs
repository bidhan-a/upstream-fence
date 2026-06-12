#![cfg_attr(target_arch = "bpf", no_std)]

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[unsafe(no_mangle)]
pub fn entrypoint(_input: *mut u8) -> u64 {
    let mut var_a: u64 = 0x1111_2222_3333_4444;
    let mut var_b: u64 = 0xAAAA_BBBB_CCCC_DDDD;

    core::hint::black_box(&mut var_a);
    core::hint::black_box(&mut var_b);

    // This should lower via __multi3 on BPF
    let prod = match var_a.checked_mul(var_b) {
        Some(v) => v,
        None => return 0,
    };

    prod ^ var_b
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
