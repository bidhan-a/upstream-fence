#![cfg_attr(target_arch = "bpf", no_std)]

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

pub struct Desc {
    pub validate: fn(&[u8]) -> bool,
    pub key: [u8; 32],
}

fn always_true(b: &[u8]) -> bool {
    !b.is_empty()
}

pub const DESC: Desc = Desc {
    validate: always_true,
    key: [
        0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7,
        0xB8, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,
        0xD7, 0xD8,
    ],
};

#[inline(never)]
fn use_desc(d: &Desc, probe: &[u8], i: usize) -> u64 {
    if !(d.validate)(probe) {
        return 1;
    }
    if d.key[i & 31] == DESC.key[i & 31] {
        0
    } else {
        1
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn entrypoint(input: *mut u8) -> u64 {
    let probe = unsafe { core::slice::from_raw_parts(input, 1) };
    let d: &Desc = core::hint::black_box(&DESC);
    let index = unsafe { core::ptr::read_volatile(input.add(16)) } as usize;
    use_desc(d, probe, index)
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
