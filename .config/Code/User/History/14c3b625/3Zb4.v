module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;

assign slt[31:1] = 0;
assign ex = 0;

/*always_comb begin
if(a[31]^b[31])
    slt[0] = a[31];
else
    slt[0] = (a-b)[31];
end*/

assign z = (op == 3'b000)?(a&b): (op == 3'b001)?(a|b): (op == 3'b010)?(a+b): (op == 3'b110)?(a-b): 32'b0;


endmodule