#![cfg_attr(any(target_arch = "bpf"), no_std)]

extern crate alloc;

use pinocchio::{AccountView, Address, ProgramResult};

pinocchio::program_entrypoint!(process_instruction);
pinocchio::default_allocator!();
pinocchio::nostd_panic_handler!();

fn process_instruction(
    _program_id: &Address,
    _accounts: &mut [AccountView],
    data: &[u8],
) -> ProgramResult {
    let boxed = alloc::boxed::Box::new(data.len());
    let val = **core::hint::black_box(&boxed);
    if val == data.len() {
        Ok(())
    } else {
        Err(pinocchio::error::ProgramError::Custom(1))
    }
}

#[cfg(test)]
mod tests {
    use mollusk_svm::{result::Check, Mollusk};
    use solana_instruction::Instruction;

    #[test]
    pub fn test_alloc() {
        let mollusk = Mollusk::new(
            &[2u8; 32].into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );
        mollusk.process_and_validate_instruction(
            &Instruction {
                program_id: [2u8; 32].into(),
                accounts: vec![],
                data: vec![0xaa, 0xbb, 0xcc],
            },
            &vec![],
            &[Check::success()],
        );
    }
}
