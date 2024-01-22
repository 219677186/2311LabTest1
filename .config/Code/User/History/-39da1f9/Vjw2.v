module yArith(z, cout, a, b, ctrl);

output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire [31:0] notB, tmp;
wire cin;

assign notB = ~b;
if(ctrl == 0)
    assign tmp = a + b;
else
    assign tmp = a + notB + 1;
/*assign tmp = (ctrl) ? notB + 1:b;*/
assign {cout, z} = (ctrl == 0) ? tmp : {tmp[31], tmp[30:0]};

endmodule