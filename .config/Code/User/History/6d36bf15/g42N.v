module labM9;
reg RegWrite, clk, ALUSrc, Mem2Reg, MemRead, MemWrite;
reg[31:0] PCin;
reg[2:0] op;
wire zero;
wire[31:0] wd, rd1, rd2, imm, ins, PCp4, z, jTarget, branch;
wire[31:0] memOut, wb;
//assign wd = z;
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
        begin
            RegWrite = 1; ALUSrc = 0; op = 3'b010;
            MemRead = 0; MemWrite = 0; Mem2Reg = 0;
        end
        else if(ins[6:0] == 7'h3 || ins[6:0] == 7'h13)
        begin
            RegWrite = 1; ALUSrc = 1; MemRead = 0; MemWrite = 0;
        end

        else if(ins[6:0] == 7'h6F)
        begin
            RegWrite = 1; ALUSrc = 1; MemRead = 0; MemWrite = 0;
        end
        else if(ins[6:0] == 7'h13)
        begin
        ALUSrc = 1;
                RegWrite = 1; MemRead = 0; MemWrite = 0; Mem2Reg = 0;
        end
        else if(ins[6:0] == 7'h23)
        begin
            ALUSrc = 1; RegWrite = 0; op = 3'b110;
            MemRead = 0; MemWrite = 0;
        end
        else if (ins[6:0] == 7'h63)
        begin
            ALUSrc = 0;
            RegWrite = 0;
            op = 3'b110;
        end

        clk = 0;
        #1;
        #4 $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb); 

        #1;
        if (ins[6:0] == 7'h63 && zero == 1)
            PCin = PCin + (imm << 1);
        else if (ins[6:0] == 7'h6F)
            PCin = PCin + (jTarget << 2);
        else
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