module yAlu(z, zero, a, b, op);
input [31:0] a, b, slt;
input [2:0] op;
input cond;
input one;
output [31:0] z;
output zero;
wire cout;

assign one = 1;

wire[31:0] addORsub, addORsub2, andop, orop

yArith #(32) my_arith(addORsub2, cout, a, b, 1);
xor my_xor(cond, a[31], b[31]);
yMux slt_mux(slt[0], addORsub2[31], a[31], cond);


wire[15:0] z16;
wire[7:0] z8;
wire[3:0] z4;
wire[1:0] z2;

assign z16 = z[15:0] | z[31:16];
assign z8 = z16[7:0] | z16[15:8];
assign z4 = z8[3:0] | z8[7:4];
assign z2 = z4[1:0] | z4[3:2];
assign zero = z2[1] | z2[0];



endmodule