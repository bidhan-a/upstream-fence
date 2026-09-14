#![cfg_attr(target_arch = "bpf", no_std)]

#[cfg(target_arch = "bpf")]
#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    unsafe { core::hint::unreachable_unchecked() }
}

#[used]
#[unsafe(no_mangle)]
pub static SMALL: [u8; 3] = [1, 2, 3];

#[repr(C, align(64))]
pub struct Align64(pub [u8; 64]);

#[used]
#[unsafe(no_mangle)]
pub static ALIGNED: Align64 = Align64([0x5a; 64]);

#[unsafe(no_mangle)]
pub extern "C" fn entrypoint(_: *mut u8) -> u64 {
    let ptr = core::hint::black_box(core::ptr::addr_of!(ALIGNED));
    (ptr as usize & 63) as u64
}

#[cfg(test)]
mod tests {
    use {mollusk_svm::Mollusk, solana_instruction::Instruction};

    #[test]
    fn aligned_static_address_is_64_byte_aligned() {
        let program_id = [2u8; 32];

        let mollusk = Mollusk::new(
            &program_id.into(),
            "target/bpfel-unknown-none/release/libupstream_fence",
        );

        let instruction = Instruction::new_with_bytes(program_id.into(), &[], vec![]);
        let result = mollusk.process_instruction(&instruction, &[]);

        // The program returns `address_of(ALIGNED) % 64`. A correctly laid-out
        // `#[repr(align(64))]` static therefore returns zero (program success).
        assert_eq!(result.raw_result, Ok(()));
    }
}
