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





endmodule