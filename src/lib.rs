#![cfg_attr(target_arch = "bpf", no_std)]

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[repr(transparent)]
struct Pubkey([u8; 32]);

static AUTH0: Pubkey = Pubkey([0x11; 32]);
static AUTH1: Pubkey = Pubkey([0x22; 32]);
static AUTH2: Pubkey = Pubkey([0x33; 32]);
static AUTH3: Pubkey = Pubkey([0x44; 32]);

#[used]
static REGISTRY: [&Pubkey; 4] = [&AUTH0, &AUTH1, &AUTH2, &AUTH3];

#[unsafe(no_mangle)]
pub fn entrypoint(input: *mut u8) -> u64 {
    // ix data starts at offset 16
    let index = unsafe { core::ptr::read_volatile(input.add(16)) } as usize;

    let registry = core::ptr::addr_of!(REGISTRY).cast::<*const Pubkey>();
    let key = unsafe { core::ptr::read_volatile(registry.add(index)) };
    let val = unsafe { core::ptr::read_volatile(key.cast::<u8>()) };
    let expected = [0x11u8, 0x22, 0x33, 0x44][index];

    if val == expected {
        0x0
    } else {
        0x1
    }
}

#[cfg(test)]
mod tests {
    use mollusk_svm::{result::Check, Mollusk};
    use solana_instruction::Instruction;

    #[test]
    fn registry_all_indices() {
        let mollusk = Mollusk::new(
            &[2u8; 32].into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );
        for index in 0..4u8 {
            mollusk.process_and_validate_instruction(
                &Instruction {
                    program_id: [2u8; 32].into(),
                    accounts: vec![],
                    data: vec![index],
                },
                &vec![],
                &[Check::success()],
            );
        }
    }
}
