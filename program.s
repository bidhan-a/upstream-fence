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
  call fn_07b8
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
  mov64 r0, 0x0
  jeq r3, 0x0, jmp_0170
  mov64 r4, 0x0
  ja jmp_0130

jmp_0118:
  mov64 r0, 0x0
  add64 r4, 0x1
  jge r4, r3, jmp_0170

jmp_0130:
  mov64 r0, r1
  add64 r0, r4
  mov64 r5, r2
  add64 r5, r4
  ldxb r5, [r5+0x0]
  ldxb r0, [r0+0x0]
  jeq r0, r5, jmp_0118
  sub64 r0, r5

jmp_0170:
  exit
  mov64 r0, r1
  jlt r3, 0x10, jmp_02c0
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_01f0
  mov64 r5, r0
  mov64 r6, r2

jmp_01c8:
  ldxb r7, [r6+0x0]
  stxb [r5+0x0], r7
  add64 r6, 0x1
  add64 r5, 0x1
  jlt r5, r4, jmp_01c8

jmp_01f0:
  add64 r2, r1
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  mov64 r6, r2
  and64 r6, 0x7
  jeq r6, 0x0, jmp_0278
  jge r4, r1, jmp_02b0
  mov64 r6, r2

jmp_0248:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0248
  ja jmp_02b0

jmp_0278:
  jge r4, r1, jmp_02b0
  mov64 r6, r2

jmp_0288:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0288

jmp_02b0:
  add64 r2, r5
  and64 r3, 0x7

jmp_02c0:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_0300

jmp_02d8:
  ldxb r3, [r2+0x0]
  stxb [r1+0x0], r3
  add64 r2, 0x1
  add64 r1, 0x1
  jlt r1, r4, jmp_02d8

jmp_0300:
  exit
  mov64 r0, r1
  sub64 r1, r2
  jge r1, r3, jmp_0470
  mov64 r1, r2
  add64 r1, r3
  mov64 r4, r0
  add64 r4, r3
  mov64 r6, r3
  jlt r3, 0x10, jmp_05c8
  mov64 r8, r4
  and64 r8, 0x7
  mov64 r7, r8
  neg64 r7
  mov64 r5, r4
  and64 r5, -0x8
  jge r5, r4, jmp_03c8
  mov64 r6, r3
  add64 r6, r2
  add64 r6, -0x1

jmp_03a0:
  ldxb r9, [r6+0x0]
  stxb [r4-0x1], r9
  add64 r6, -0x1
  add64 r4, -0x1
  jlt r5, r4, jmp_03a0

jmp_03c8:
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
  jeq r9, 0x0, jmp_0570
  jge r4, r5, jmp_05b8
  sub64 r3, r8
  add64 r3, r2
  add64 r3, -0x8

jmp_0440:
  ldxdw r2, [r3+0x0]
  stxdw [r5-0x8], r2
  add64 r3, -0x8
  add64 r5, -0x8
  jlt r4, r5, jmp_0440
  ja jmp_05b8

jmp_0470:
  mov64 r1, r0
  jlt r3, 0x10, jmp_0660
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_04e8
  mov64 r5, r0
  mov64 r6, r2

jmp_04c0:
  ldxb r7, [r6+0x0]
  stxb [r5+0x0], r7
  add64 r6, 0x1
  add64 r5, 0x1
  jlt r5, r4, jmp_04c0

jmp_04e8:
  add64 r2, r1
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  mov64 r6, r2
  and64 r6, 0x7
  jeq r6, 0x0, jmp_0618
  jge r4, r1, jmp_0650
  mov64 r6, r2

jmp_0540:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0540
  ja jmp_0650

jmp_0570:
  jge r4, r5, jmp_05b8
  sub64 r3, r8
  add64 r3, r2
  add64 r3, -0x8

jmp_0590:
  ldxdw r2, [r3+0x0]
  stxdw [r5-0x8], r2
  add64 r3, -0x8
  add64 r5, -0x8
  jlt r4, r5, jmp_0590

jmp_05b8:
  add64 r1, r7
  and64 r6, 0x7

jmp_05c8:
  mov64 r2, r4
  sub64 r2, r6
  jge r2, r4, jmp_06a0
  add64 r1, -0x1

jmp_05e8:
  ldxb r3, [r1+0x0]
  stxb [r4-0x1], r3
  add64 r1, -0x1
  add64 r4, -0x1
  jlt r2, r4, jmp_05e8
  ja jmp_06a0

jmp_0618:
  jge r4, r1, jmp_0650
  mov64 r6, r2

jmp_0628:
  ldxdw r7, [r6+0x0]
  stxdw [r4+0x0], r7
  add64 r6, 0x8
  add64 r4, 0x8
  jlt r4, r1, jmp_0628

jmp_0650:
  add64 r2, r5
  and64 r3, 0x7

jmp_0660:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_06a0

jmp_0678:
  ldxb r3, [r2+0x0]
  stxb [r1+0x0], r3
  add64 r2, 0x1
  add64 r1, 0x1
  jlt r1, r4, jmp_0678

jmp_06a0:
  exit
  mov64 r0, r1
  jlt r3, 0x10, jmp_0780
  mov64 r1, r0
  neg64 r1
  and64 r1, 0x7
  mov64 r4, r0
  add64 r4, r1
  jge r0, r4, jmp_0708
  mov64 r5, r0

jmp_06f0:
  stxb [r5+0x0], r2
  add64 r5, 0x1
  jlt r5, r4, jmp_06f0

jmp_0708:
  sub64 r3, r1
  mov64 r5, r3
  and64 r5, -0x8
  mov64 r1, r4
  add64 r1, r5
  jge r4, r1, jmp_0778
  mov64 r5, r2
  and64 r5, 0xff
  lddw r6, 0x101010101010101
  mul64 r5, r6

jmp_0760:
  stxdw [r4+0x0], r5
  add64 r4, 0x8
  jlt r4, r1, jmp_0760

jmp_0778:
  and64 r3, 0x7

jmp_0780:
  mov64 r4, r1
  add64 r4, r3
  jge r1, r4, jmp_07b0

jmp_0798:
  stxb [r1+0x0], r2
  add64 r1, 0x1
  jlt r1, r4, jmp_0798

jmp_07b0:
  exit

fn_07b8:
  mul64 r2, r3
  mov64 r6, r1
  rsh64 r6, 0x20
  mov64 r0, r3
  rsh64 r0, 0x20
  mov64 r5, r0
  mul64 r5, r6
  add64 r5, r2
  mul64 r4, r1
  add64 r5, r4
  lsh64 r3, 0x20
  rsh64 r3, 0x20
  mov64 r2, r3
  mul64 r2, r6
  lsh64 r1, 0x20
  rsh64 r1, 0x20
  mul64 r3, r1
  mov64 r4, r3
  rsh64 r4, 0x20
  add64 r4, r2
  mov64 r2, r4
  rsh64 r2, 0x20
  add64 r5, r2
  mul64 r0, r1
  lsh64 r4, 0x20
  rsh64 r4, 0x20
  add64 r4, r0
  mov64 r1, r4
  rsh64 r1, 0x20
  add64 r5, r1
  lsh64 r4, 0x20
  lsh64 r3, 0x20
  rsh64 r3, 0x20
  or64 r4, r3
  mov64 r0, r4
  mov64 r2, r5
  exit
  jgt r3, 0x20, jmp_0978
  mov64 r4, 0x0
  mov64 r5, 0x0
  mov64 r0, 0x1
  ja jmp_0950

jmp_0908:
  mov64 r6, r1
  add64 r6, r4
  mov64 r7, r2
  add64 r7, r4
  ldxdw r7, [r7+0x0]
  ldxdw r6, [r6+0x0]
  mov64 r4, r5
  jeq r6, r7, jmp_0950
  ja jmp_0a08

jmp_0950:
  add64 r5, 0x8
  jle r5, r3, jmp_0908
  mov64 r0, 0x0
  jge r4, r3, jmp_0a08
  ja jmp_09c8

jmp_0978:
  mov64 r4, 0x0
  stxw [r10-0x4], r4
  mov64 r4, r10
  add64 r4, -0x4
  call sol_memcmp_
  ldxw r0, [r10-0x4]
  ja jmp_0a08

jmp_09b0:
  add64 r4, 0x1
  mov64 r0, 0x0
  jge r4, r3, jmp_0a08

jmp_09c8:
  mov64 r5, r1
  add64 r5, r4
  mov64 r6, r2
  add64 r6, r4
  mov64 r0, 0x1
  ldxb r6, [r6+0x0]
  ldxb r5, [r5+0x0]
  jeq r5, r6, jmp_09b0

jmp_0a08:
  exit
