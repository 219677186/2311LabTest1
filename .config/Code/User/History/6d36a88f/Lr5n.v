module labM3;
reg[4:0] rs1, rs2, wn;
reg[31:0] wd;
wire[31:0] rd1, rd2;
reg clk, w;
integer i;

rf #(32) myRF(rd1, rd2, rs1, rs2, wn, wd, clk, w);

initial
begin
w = 1;
for(i = 0; i<32; i = i + 1)
begin
    clk = 0; #1;
    wd = i * i; #1;
    wn = i; #1;
    clk = 1l #1;
    #1;
end
$finish;

end
endmodule