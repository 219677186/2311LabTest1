addi a0, x0, 12  ;user n
add x4, a0, x0 ;n copy
addi x3, x0, 1 ;Const 1
add a0, x0, x0
Loop: addi x9, x4, -1 ;Store n-1
blt x9, x3, Exit
add a0, a0, x9
addi x4, x4, -1
beq x0, x0, Loop


Exit: 
