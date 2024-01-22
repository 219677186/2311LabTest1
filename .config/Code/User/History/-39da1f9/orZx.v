module yArith(z, cout, a, b, ctrl);

output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire [31:0] notB, tmp;
wire cin;

assign notB = ~b;
assign tmp = (ctrl == 1) ? notB + 1 : b;
assign {cout, z} = a + tmp;

endmodule