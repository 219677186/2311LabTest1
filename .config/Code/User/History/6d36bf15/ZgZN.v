module labM9;
reg RegWrite, clk, ALUSrc;
reg[31:0] PCin;
reg[2:0] op;
wire zero;
wire[31:0] wd, rd1, rd2, imm, ins, PCp4, z, jTarget, branch;
assign wd = z;
yIF my_IF(ins, PCp4, PCin, clk);
yID my_ID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX my_Ex(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM my_Dm(memOut, z, rd2, clk, MemRead, MemWrite);
yWB my_Wb(wb, z, memOut, Mem2Reg);
assign wd = wb;

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
        Mem2Reg = 0;
        MemRead = 1;
        MemWrite = 0;
        if(ins[6:0] == 7'h33)
            RegWrite = 1; ALUSrc = 0;
        
        if(ins[6:0] == 7'h3 || ins[6:0] == 7'h13)
            RegWrite = 1; ALUSrc = 1;

        if(ins[6:0] == 7'h6F)
            RegWrite = 1; ALUSrc = 1;

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