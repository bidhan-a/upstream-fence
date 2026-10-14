#![cfg_attr(any(target_os = "solana"), no_std)]

#[cfg(target_arch = "bpf")]
use solana_compiler_builtins as _;

use pinocchio::{error::ProgramError, AccountView, Address, ProgramResult};

pinocchio::program_entrypoint!(process_instruction);
pinocchio::no_allocator!();
pinocchio::nostd_panic_handler!();

pub fn process_instruction(
    program_id: &Address,
    accounts: &mut [AccountView],
    data: &[u8],
) -> ProgramResult {
    let [counter] = accounts else {
        return Err(ProgramError::NotEnoughAccountKeys);
    };

    if !counter.owned_by(program_id) {
        return Err(ProgramError::IncorrectProgramId);
    }

    if !counter.is_writable() {
        return Err(ProgramError::InvalidAccountData);
    }

    let by: [u8; 8] = data
        .try_into()
        .map_err(|_| ProgramError::InvalidInstructionData)?;
    let mut bytes = counter.try_borrow_mut()?;
    let stored: &mut [u8; 8] = (&mut bytes[..])
        .try_into()
        .map_err(|_| ProgramError::InvalidAccountData)?;
    let next = u64::from_le_bytes(*stored)
        .checked_add(u64::from_le_bytes(by))
        .ok_or(ProgramError::ArithmeticOverflow)?;
    *stored = next.to_le_bytes();
    Ok(())
}

#[cfg(test)]
mod tests {
    use mollusk_svm::{result::Check, Mollusk};
    use solana_account::Account;
    use solana_instruction::{AccountMeta, Instruction};
    use solana_pubkey::Pubkey;

    #[test]
    pub fn test_alloc() {
        let counter_key: Pubkey = [9u8; 32].into();
        let counter_account = Account {
            lamports: 1_000_000,
            data: 37u64.to_le_bytes().to_vec(),
            owner: [2u8; 32].into(),
            ..Default::default()
        };
        let mollusk = Mollusk::new(
            &[2u8; 32].into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );
        let result = mollusk.process_and_validate_instruction(
            &Instruction {
                program_id: [2u8; 32].into(),
                accounts: vec![AccountMeta::new(counter_key, false)],
                data: 5u64.to_le_bytes().to_vec(),
            },
            &vec![(counter_key, counter_account)],
            &[Check::success()],
        );

        println!("add 5 to 37: {} CU", result.compute_units_consumed);
    }
}
