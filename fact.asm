addi a1, x0, 1
addi a0, x0, 10

jal x1, fact
beq, x0, x0, Exit
fact: blt x0, a0, recu
add a0, x0, a1
jalr x0, 0(x1)
recu: mul a1, a1, a0
addi a0, a0, -1
jal x0, fact

Exit: