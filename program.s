.globl entrypoint

entrypoint:
  lddw r1, 0x1111222233334444
  stxdw [r10-0x18], r1
  lddw r1, -0x5555444433332223
  stxdw [r10-0x10], r1
  mov64 r1, r10
  add64 r1, -0x18
  stxdw [r10-0x8], r1
  mov64 r1, r10
  add64 r1, -0x8
  mov64 r1, r10
  add64 r1, -0x10
  stxdw [r10-0x8], r1
  mov64 r1, r10
  add64 r1, -0x8
  mov64 r6, 0x0
  ldxdw r1, [r10-0x18]
  ldxdw r7, [r10-0x10]
  mov64 r2, 0x0
  mov64 r3, r7
  mov64 r4, 0x0
  call fn_00f8
  mov64 r1, 0x1
  jne r2, 0x0, jmp_00d0
  mov64 r1, 0x0

jmp_00d0:
  jne r1, 0x0, jmp_00e8
  xor64 r0, r7
  mov64 r6, r0

jmp_00e8:
  mov64 r0, r6
  exit

fn_00f8:
  stxdw [r10-0x8], r1
  stxdw [r10-0x18], r2
  ldxdw r2, [r2+0x0]
  mov64 r8, r2
  lsh64 r8, 0x20
  rsh64 r8, 0x20
  stxdw [r10-0x10], r3
  ldxdw r4, [r3+0x0]
  mov64 r7, r4
  lsh64 r7, 0x20
  rsh64 r7, 0x20
  mov64 r6, r2
  rsh64 r6, 0x20
  mov64 r1, r7
  mul64 r1, r8
  mul64 r7, r6
  mov64 r0, r4
  rsh64 r0, 0x20
  mov64 r5, r0
  mul64 r5, r8
  mov64 r9, r5
  add64 r9, r7
  mov64 r3, 0x1
  mov64 r8, 0x1
  jlt r9, r5, jmp_01c8
  mov64 r8, 0x0

jmp_01c8:
  mov64 r5, r9
  lsh64 r5, 0x20
  mov64 r7, r1
  add64 r7, r5
  jlt r7, r1, jmp_01f8
  mov64 r3, 0x0

jmp_01f8:
  ldxdw r5, [r10-0x8]
  stxdw [r5+0x0], r7
  rsh64 r9, 0x20
  lsh64 r8, 0x20
  or64 r8, r9
  ldxdw r1, [r10-0x18]
  ldxdw r1, [r1+0x8]
  mul64 r4, r1
  ldxdw r1, [r10-0x10]
  ldxdw r1, [r1+0x8]
  mul64 r1, r2
  mul64 r0, r6
  add64 r0, r8
  add64 r1, r4
  add64 r0, r3
  add64 r0, r1
  stxdw [r5+0x8], r0
  exit
  mov64 r0, 0x0
  jeq r3, 0x0, jmp_0300
  mov64 r4, 0x0
  ja jmp_02c0

jmp_02a8:
  mov64 r0, 0x0
  add64 r4, 0x1
  jge r4, r3, jmp_0300

jmp_02c0:
  mov64 r0, r1
  add64 r0, r4
  mov64 r5, r2
  add64 r5, r4
  ldxb r5, [r5+0x0]
  ldxb r0, [r0+0x0]
  jeq r0, r5, jmp_02a8
  sub64 r0, r5

jmp_0300:
  exit
  mov64 r0, 0x0
  jeq r3, 0x0, jmp_0380
  mov64 r4, 0x0
  ja jmp_0340

jmp_0328:
  mov64 r0, 0x0
  add64 r4, 0x1
  jge r4, r3, jmp_0380

jmp_0340:
  mov64 r0, r1
  add64 r0, r4
  mov64 r5, r2
  add64 r5, r4
  ldxb r5, [r5+0x0]
  ldxb r0, [r0+0x0]
  jeq r0, r5, jmp_0328
  sub64 r0, r5

jmp_0380:
  exit
  mov64 r0, r1
  jlt r3, 0x10, jmp_04d0
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_0400
  mov64 r5, r0
  mov64 r6, r2

jmp_03d8:
  ldxb r7, [r6+0x0]
  stxb [r5+0x0], r7
  add64 r6, 0x1
  add64 r5, 0x1
  jlt r5, r4, jmp_03d8

jmp_0400:
  add64 r2, r1
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  mov64 r6, r2
  and64 r6, 0x7
  jeq r6, 0x0, jmp_0488
  jge r4, r1, jmp_04c0
  mov64 r6, r2

jmp_0458:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0458
  ja jmp_04c0

jmp_0488:
  jge r4, r1, jmp_04c0
  mov64 r6, r2

jmp_0498:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0498

jmp_04c0:
  add64 r2, r5
  and64 r3, 0x7

jmp_04d0:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_0510

jmp_04e8:
  ldxb r3, [r2+0x0]
  stxb [r1+0x0], r3
  add64 r2, 0x1
  add64 r1, 0x1
  jlt r1, r4, jmp_04e8

jmp_0510:
  exit
  mov64 r0, r1
  sub64 r1, r2
  jge r1, r3, jmp_0680
  mov64 r1, r2
  add64 r1, r3
  mov64 r4, r0
  add64 r4, r3
  mov64 r6, r3
  jlt r3, 0x10, jmp_07d8
  mov64 r8, r4
  and64 r8, 0x7
  mov64 r7, r8
  neg64 r7
  mov64 r5, r4
  and64 r5, -0x8
  jge r5, r4, jmp_05d8
  mov64 r6, r3
  add64 r6, r2
  add64 r6, -0x1

jmp_05b0:
  ldxb r9, [r6+0x0]
  stxb [r4-0x1], r9
  add64 r6, -0x1
  add64 r4, -0x1
  jlt r5, r4, jmp_05b0

jmp_05d8:
  mov64 r6, r3
  sub64 r6, r8
  add64 r1, r7
  mov64 r7, r6
  and64 r7, -0x8
  mov64 r4, r5
  sub64 r4, r7
  neg64 r7
  mov64 r9, r1
  and64 r9, 0x7
  jeq r9, 0x0, jmp_0780
  jge r4, r5, jmp_07c8
  sub64 r3, r8
  add64 r3, r2
  add64 r3, -0x8

jmp_0650:
  ldxdw r2, [r3+0x0]
  stxdw [r5-0x8], r2
  add64 r3, -0x8
  add64 r5, -0x8
  jlt r4, r5, jmp_0650
  ja jmp_07c8

jmp_0680:
  mov64 r1, r0
  jlt r3, 0x10, jmp_0870
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_06f8
  mov64 r5, r0
  mov64 r6, r2

jmp_06d0:
  ldxb r7, [r6+0x0]
  stxb [r5+0x0], r7
  add64 r6, 0x1
  add64 r5, 0x1
  jlt r5, r4, jmp_06d0

jmp_06f8:
  add64 r2, r1
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  mov64 r6, r2
  and64 r6, 0x7
  jeq r6, 0x0, jmp_0828
  jge r4, r1, jmp_0860
  mov64 r6, r2

jmp_0750:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0750
  ja jmp_0860

jmp_0780:
  jge r4, r5, jmp_07c8
  sub64 r3, r8
  add64 r3, r2
  add64 r3, -0x8

jmp_07a0:
  ldxdw r2, [r3+0x0]
  stxdw [r5-0x8], r2
  add64 r3, -0x8
  add64 r5, -0x8
  jlt r4, r5, jmp_07a0

jmp_07c8:
  add64 r1, r7
  and64 r6, 0x7

jmp_07d8:
  mov64 r2, r4
  sub64 r2, r6
  jge r2, r4, jmp_08b0
  add64 r1, -0x1

jmp_07f8:
  ldxb r3, [r1+0x0]
  stxb [r4-0x1], r3
  add64 r1, -0x1
  add64 r4, -0x1
  jlt r2, r4, jmp_07f8
  ja jmp_08b0

jmp_0828:
  jge r4, r1, jmp_0860
  mov64 r6, r2

jmp_0838:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0838

jmp_0860:
  add64 r2, r5
  and64 r3, 0x7

jmp_0870:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_08b0

jmp_0888:
  ldxb r3, [r2+0x0]
  stxb [r1+0x0], r3
  add64 r2, 0x1
  add64 r1, 0x1
  jlt r1, r4, jmp_0888

jmp_08b0:
  exit
  mov64 r0, r1
  jlt r3, 0x10, jmp_0990
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_0918
  mov64 r5, r0

jmp_0900:
  stxb [r5+0x0], r2
  add64 r5, 0x1
  jlt r5, r4, jmp_0900

jmp_0918:
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  jge r4, r1, jmp_0988
  mov64 r5, r2
  and64 r5, 0xff
  lddw r6, 0x101010101010101
  mul64 r5, r6

jmp_0970:
  stxdw [r4+0x0], r5
  add64 r4, 0x8
  jlt r4, r1, jmp_0970

jmp_0988:
  and64 r3, 0x7

jmp_0990:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_09c0

jmp_09a8:
  stxb [r1+0x0], r2
  add64 r1, 0x1
  jlt r1, r4, jmp_09a8

jmp_09c0:
  exit
