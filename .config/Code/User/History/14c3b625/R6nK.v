module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;


assign ex = 0;

assign z = (op == 3'b000)?(a&b): (op == 3'b001)?(a|b): (op == 3'b010)?(a+b): (op == 3'b110)?(a-b): (op == 3'b111)?(a<b)?1:0: 32'b0;

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