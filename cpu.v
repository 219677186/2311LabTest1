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
module yC1(rtype, lw, sw, jump, branch, opCode);
	output rtype, lw, sw, jump, branch;
	input [5:0] opCode;
	wire [0:0] not5 ,not4, not3, not2, not1, not0;
	not (not5, opCode[5]);
	not (not4, opCode[4]);
	not (not3, opCode[3]);
	not (not2, opCode[2]);
	not (not1, opCode[1]);
	not (not0, opCode[0]);
	and (rtype, not5, not4, not3, not2, not1, not0);			//--------R-Type(000000)---------
	and (jump, not5, not4, not3, not2, opCode[1], not0);			//--------Jump(000010)-----------
	and (branch, not5, not4,not3, opCode[2], not1, not0);			//--------branch(000100)---------
  	and (sw, opCode[5], not4 ,opCode[3], not2, opCode[1], opCode[0]);	//--------sw(101011)-------------
	and (lw, opCode[5], not4, not3, not2, opCode[1], opCode[0]);		//--------lw(100011)-------------
endmodule
//-----------------------------------------------------------------------------------------------
//-----------------------------------yC2---------------------------------------------------------

module yC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, branch);
	output RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite;
	input rtype, lw, sw, branch;
	assign RegDst = rtype;				//use [rd] field
	nor (ALUSrc, rtype, branch);			//0 - do calculation; 1 - add immediate
	nor (RegWrite, sw, branch);			//need to write to a register
	assign Mem2Reg = lw;
	assign MemRead = lw;
	assign MemWrite = sw;
endmodule
//-----------------------------------------------------------------------------------------------
//-----------------------------------yC3---------------------------------------------------------

module yC3(ALUop, rtype, branch);
	output [1:0] ALUop;
	input rtype, branch;
	assign ALUop[0] = branch;
	assign ALUop[1] = rtype;
endmodule
//-----------------------------------------------------------------------------------------------
//-----------------------------------yC4---------------------------------------------------------

module yC4(op, ALUop, fnCode);
	output [2:0] op;
	input [5:0] fnCode;
	input [1:0] ALUop;
	wire t1, t2;
	or (t1, fnCode[0], fnCode[3]);
	and (t2, fnCode[1], ALUop[1]);
	and (op[0], ALUop[1], t1);
	nand (op[1], ALUop[1], fnCode[2]);
	or (op[2], t2, ALUop[0]);
endmodule
module yChip(ins, rd2, wb, entryPoint, INT, clk);
	output [31:0] ins, rd2, wb;
	input [31:0] entryPoint;
	input INT, clk;
	wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb, PCin;
	wire [25:0] jTarget;
	wire [5:0] opCode, fnCode;
	wire [2:0] op;
	wire [1:0] ALUop;
	wire zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, jump, branch, rtype, lw, sw;
	yIF myIF(ins, PCp4, PCin, clk);
	yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
	yEX myEX(z, zero, rd1, rd2, imm, op, ALUSrc);
	yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
	yWB myWB(wb, z, memOut, Mem2Reg);
	assign wd = wb;
	yPC myPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);
	assign opCode = ins[31:26];
	yC1 myC1(rtype, lw, sw, jump, branch, opCode);
	yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, branch);
	assign fnCode = ins[5:0];
	yC3 myC3(ALUop, rtype, branch);
	yC4 myC4(op, ALUop, fnCode);
endmodule