module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;

not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);

endmodule/*module yMux2(z, a, b, c);*/
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;

/*For LabL2.v*/
/*yMux1 upper(z[0], a[0], b[0], c);*/
/*yMux1 lower(z[1], a[1], b[1], c);*/

/*For LabL3.v*/
yMux1 mine[SIZE-1:0](z, a, b, c);

endmodule
module yMux4to1(z, a0, a1, a2, a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;

yMux #(SIZE) lo(zLo, a0, a1, c[0]);
yMux #(SIZE) hi(zHi, a2, a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);

endmodule
module yAdder1(z, cout, a, b, cin);
output z, cout;
input a, b, cin;

xor left_xor(tmp, a, b);
xor right_xor(z, cin, tmp);
and left_and(outL, a, b);
and right_and(outR, tmp, cin);
or my_or(cout, outR, outL);

endmodule
module yAdder(z, cout, a, b, cin);
output [31:0]z;
output cout;
input [31:0]a, b;
input cin;
wire[31:0] in, out;

yAdder1 mine[31:0](z, out, a, b, in);

assign in[0] = cin;
assign in[1] = out[0];
assign in[2] = out[1];
assign in[3] = out[2];
assign in[4] = out[3];
assign in[5] = out[4];
assign in[6] = out[5];
assign in[7] = out[6];
assign in[8] = out[7];
assign in[9] = out[8];
assign in[10] = out[9];
assign in[11] = out[10];
assign in[12] = out[11];
assign in[13] = out[12];
assign in[14] = out[13];
assign in[15] = out[14];
assign in[16] = out[15];
assign in[17] = out[16];
assign in[18] = out[17];
assign in[19] = out[18];
assign in[20] = out[19];
assign in[21] = out[20];
assign in[22] = out[21];
assign in[23] = out[22];
assign in[24] = out[23];
assign in[25] = out[24];
assign in[26] = out[25];
assign in[27] = out[26];
assign in[28] = out[27];
assign in[29] = out[28];
assign in[30] = out[29];
assign in[31] = out[30];

//assign in[31] = cout;





endmodule
module yArith(z, cout, a, b, ctrl);

output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire [31:0] notB, tmp;
wire cin;

assign cin = ctrl;
not my_not [31:0](notB, b);
yMux #(32) my_mux(tmp, b, notB, cin);
yAdder my_adder(z, cout, a, tmp, cin);

endmodule
module yAlu(z, zero, a, b, op);
input [31:0] a, b, slt;
input [2:0] op;
input cond;
input one;
output [31:0] z;
output zero;
wire cout;
wire null;
assign one = 1;
wire [15:0] z16;
wire [7:0] z8;
wire [3:0] z4;
wire [1:0] z2;
wire z1, z0;

wire[31:0] addORsub, addORsub2, andop, orop;

yArith #(32) my_arith(addORsub2, cout, a, b, one);
xor #(1) my_xor(cond, a[31], b[31]);
yMux #(1) slt_mux(slt[0], addORsub2[31], a[31], cond);


or or16[15:0](z16, z[15:0], z[31:16]);
or or8[7:0](z8, z16[7:0], z16[15:8]);
or or4[3:0](z4, z8[3:0], z8[7:4]);
or or2[1:0](z2, z4[1:0], z4[3:2]);
or or1[15:0](z1, z2[1], z2[0]);

not my_not(z0, z1);
assign zero = z0;

and my_and[31:0](andop, a, b);
or my_or[31:0](orop, a, b);
yArith#(32) my_Arith(addORsub, null, a, b, op[2]);
yMux4to1 #(32) my_Mux4to1(z, andop, orop, addORsub, slt, op[1:0]);


endmodule
module yIF(ins, PCp4, PCin, clk);
output [31:0] ins, PCp4;
input [31:0] PCin;
input clk;
wire [31:0] pcOut;
register #(32) pc(pcOut, PCin, clk, 1'b1);
yAlu myAlu(PCp4, null, pcOut, 32'd4, 3'b010);
mem myMem(ins, pcOut, 32'b0, clk, 1'b1, 1'b0);
endmodule 
module yID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk); 
	output [31:0] rd1, rd2, imm;         // rs and rt and immediate 
	output [25:0] jTarget; 		     // jump
	input [31:0] ins, wd; 		     // wd = value need to be written on rd and ins is instruction where rd id ins[20:16] or ins[15:11]
	input RegDst, RegWrite, clk; 	     // regDst decide type of ins and regWrite allow to write and clk is clock
	wire [4:0] rn1, rn2, rn3, wn;
	assign rn1 = ins[25:21];
	assign rn2 = ins[20:16];
	assign rn3 = ins[15:11];
	assign jTarget = ins[25:0];
	assign imm[15:0] = ins[15:0];
	yMux #(5) myMux(wn, rn2, rn3, RegDst);
	rf 	   myRf(rd1, rd2, rn1, rn2, wn, wd, clk, RegWrite);
	yMux #(16) se(imm[31:16], 16'b0, 16'hffff, ins[15]);
endmodule 
module yEX(z, zero, rd1, rd2, imm, op, ALUSrc);
input[31:0] rd1, rd2, imm;
input ALUSrc;
input[2:0] op;
output zero;
output[31:0] z, b;

yMux #(32) my_mux(b, rd2, imm, ALUSrc);
yAlu #(32) my_Alu2(z, zero, b, rd1, op);

endmodule
module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite);
output[31:0] memOut;
input clk, MemRead, MemWrite;
input[31:0] exeOut, rd2, z;

mem my_mem(memOut, z, rd2, clk, MemRead, MemWrite);

endmodule
module yWB(wb, exeOut, memOut, Mem2Reg);
output[31:0] wb;
input[31:0] exeOut, memOut;
input Mem2Reg;
yMux #(32) writeback(wb, exeOut, memOut, Mem2Reg);
endmodule
module yPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);
	output [31:0] PCin;
	input [31:0] PCp4, entryPoint, imm;
	input [25:0] jTarget;
	input INT, zero, branch, jump;
	wire [31:0] immX4, bTarget, jTargetX4, choiceA, choiceB;
	wire doBranch, zf;
	assign immX4[31:2] = imm[29:0];
	assign immX4[1:0] = 2'b00; 							//immX4 is the real address (imm * 4)
	yAlu beq(bTarget, zf, PCp4, immX4, 3'b010);					//bTarget = PCp4 + imm * 4
	and (doBranch, branch, zero); 							//doBranch
	yMux #(32) mux1(choiceA, PCp4, bTarget, doBranch);				//if jump branch or execute the next
	assign jTargetX4[31:28] = PCp4[31:28];
	assign jTargetX4[27:2] = jTarget[25:0];
	assign jTargetX4[1:0] = 2'b00;
	yMux #(32) mux2(choiceB, choiceA, jTargetX4, jump);				// if not jump then use choiceA
	yMux #(32) mux3(PCin, choiceB, entryPoint, INT);				// choose between previous and entryPoint
endmodule
module yC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
output isStype, isRtype, isItype, isLw, isjump, isbranch;
input [6:0] opCode;
wire lwor, ISselect, JBselect, sbz, sz;
assign isjump= opCode[3];
or is_lw(lwor, opCode[6], opCode[5], opCode[4], opCode[3], opCode[2]); not (isLw, lwor);
xor my_xor(ISselect, opCode[6], opCode[3], opCode[2], opCode[1], opCode[0]);
and my_and(isStype, ISselect, opCode[5]);
and my_and2(isItype, ISselect, opCode[4]);
and my_and3(isRtype, opCode[5], opCode[4]);
and my_and4(JBselect, opCode[6], opCode[5]);
not is_branch(sbz, opCode[3]);
and branch_and(isbranch, JBselect, sbz);
endmodule
module yC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);
output RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg;
input isStype, isRtype, isItype, isLw, isjump, isbranch;
nor (ALUSrc, isRtype, isbranch);
nor (RegWrite, isStype, isbranch);
assign Mem2Reg = isLw;
assign MemRead = isLw;
assign MemWrite = isStype;
endmodule
module yC3(ALUop, isRtype, isbranch);
output [1:0] ALUop;
input isRtype, isbranch;
assign ALUop[1] = isRtype;
assign ALUop[0] = isbranch;
endmodule
module yC4(op, ALUop, funct3);
output [2:0] op;
input [2:0] funct3;
input [1:0] ALUop;
wire f21out, f10out, upperAndOut, notALU, notf3;
xor f_21 (f21out, funct3[2], funct3[1]);
and upper_And(upperAndOut, ALUop[1], f21out);
or upper_Or(op[2], ALUop[0], upperAndOut);
not ALUop1no(notALU, ALUop[1]);
not f3no(notf3, funct3[1]);
or lowerOr(op[1], notALU, notf3);
xor f10 (f10out, funct3[1], funct3[0]);
and lowerAnd(op[0], ALUop[1], f10out);
endmodule
module yChip(ins, rd2, wb, entryPoint, INT, clk);
output [31:0] ins, rd2, wb;
input [31:0] entryPoint;
input INT, clk;
wire [31:0] PCin, PC;
wire [2:0] op, funct3;
wire [31:0] wd, rd1, imm, PCp4, z, branch;
wire [31:0] jTarget;
wire [31:0] memOut;
wire zero;
wire [6:0] opCode;
wire isStype, isRtype, isItype, isLw, isjump, isbranch;
wire RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg;
wire [1:0] ALUop;
yIF myIF(ins, PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
yPC myPC(PCin, PC, PCp4, INT, entryPoint, branch, jTarget, zero, isbranch, isjump);
assign opCode = ins[6:0];
yC1 myC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);
yC3 myC3(ALUop, isRtype, isbranch);
assign funct3=ins[14:12];
yC4 myC4(op, ALUop, funct3);
assign wd = wb; 
endmodule