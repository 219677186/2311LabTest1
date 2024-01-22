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
output[31:0] ins, PCp4;
input[31:0] PCin;
input clk;
wire[31:0] pcOut;
register #(32) pc(pcOut, PCin, clk, 1'b1);
yAlu my_Alu(PCp4, null, pcOut, 32'd4, 3'b010);
mem my_Mem(ins, pcOut, 32'b0, clk, 1'b1, 1'b0);
endmodule
module yID(rd1, rd2, immOut, jTarget, branch, ins, wd, RegWrite, clk);
output[31:0] rd1, rd2, immOut;
output[31:0] jTarget;
output[31:0] branch;
input[31:0] ins, wd;
input RegWrite, clk;
wire[19:0] zeros, ones;
wire[11:0] zerosj, onesj;
wire[31:0] imm, saveImm;

rf my_RF(rd1, rd2, ins[19:15], ins[24:20], ins[11:7], wd, clk, RegWrite);

assign imm[11:0] = ins[31:20];
assign ones = 20'hFFFFF;
assign zeros = 20'h00000;
yMux #(20) se(imm[32:12], zeros, ones, ins[31]);
yMux #(32) immSelection(immOut, imm, saveImm, ins[5]);

assign branch[11] = ins[31];
assign branch[10] = ins[7];
assign branch[9:4] = ins[30:25];
assign branch[3:0] = ins[11:8];
yMux #(20) bra(branch[31:12], zeros, ones, ins[31]);