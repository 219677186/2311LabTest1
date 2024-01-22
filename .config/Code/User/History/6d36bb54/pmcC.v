module labM8;
reg[31:0] PCin;
reg clk, RegWrite, ALUSrc;
reg[2:0] op;
wire zero;
wire[31:0] wd, rd1, rd2, imm, ins, PCp4, z, jTarget, branch;
yIF my_IF(ins, PCp4, PCin, clk);
yID my_ID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX my_Ex(z, zero, rd1, rd2, imm, op, ALUSrc);
assign wd = z;

initial
begin
    PCin = 16'h28;
    repeat(11)
    begin
        clk = 1;
        #1;
        ALUSrc = 1;
        RegWrite = 0;
        op = 3'b010;
        if(ins[6:0] == 7'h33)
            RegWrite = 1; ALUSrc = 0;
        else if(ins[6:0] == 7'h3 || ins[6:0] == 7'h13)
        begin
            RegWrite = 1; ALUSrc = 1;
        end

        else if(ins[6:0] == 7'h6F)
        begin
            RegWrite = 1; ALUSrc = 1;
        end

        clk = 0;
        #1;
        #4 $display("ins=%h rd1=%h rd2=%h imm=%h jTarget=%h z=%h zero=%h", ins, rd1, rd2, imm, jTarget, z, zero);
        #1;

        PCin = PCp4;
        end
        #1;
    $finish;
end
always
begin
    #4 clk = ~clk;
end

endmodule