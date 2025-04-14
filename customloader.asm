// === BootROM Custom Loader: iPhone 16 ===
// Entry: 0x7FF02200

.section ".text"
.global _custom_loader
_custom_loader:
    // Patch SEPOS entry to NOPs (skip Apple's bootloader)
    ldr x0, =0x9FF00000         // SEPOS start
    mov x1, #0x1F2003D5         // nop in AArch64
    str x1, [x0]
    str x1, [x0, #4]
    str x1, [x0, #8]

    // Unlock Flash Protection Registers
    ldr x1, =0x80002000
    mov x2, #0xCAFEBABE
    str x2, [x1]

    // Enable full debug UART console
    ldr x1, =0x7FF05000
    mov x2, #0x1
    str x2, [x1]

    // Jump to custom root shell (placeholder)
    ldr x0, =_root_shell
    br x0

_root_shell:
    // Simulate root console print
    ldr x1, =_msg_root
_print_loop:
    ldrb w2, [x1], #1
    cbz w2, _halt
    strb w2, [x1]
    b _print_loop

_msg_root:
    .asciz "BOOTROM ROOTED – FULL ACCESS GRANTED"

_halt:
    wfi
    b _halt
