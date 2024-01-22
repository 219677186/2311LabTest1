	addi a1, x0, 1   ;accumulator
	addi a0, x0, 5   ;n=5
	jal x1, fact     ;call fact
	ebreak x0, x0, 0
fact:	blt x0, a0, recu ;if(0<a0) recursion
	add a0, x0, a1   ;if(a0<=0)return accumulator
	jalr x0, 0(x1)   ;return
recu:	mul a1, a1, a0   ;fact(a0)=a0*fact(a0-1)
	addi a0, a0, -1  ;a0=a0-1
	jal x0, fact     ;jump instead of a recursive call 