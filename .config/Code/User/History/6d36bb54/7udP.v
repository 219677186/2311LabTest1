module labM;
    reg [31:0] PCin;
    reg RegWrite, clk, ALUSrc;
    reg [2:0] op;

    wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, branch;
    wire [31:0] jTarget;
    wire zero;

    yIF myIF(ins, PCp4, PCin, clk);
    yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
    yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);

    assign wd = z;

    initial
    begin
        //------------------------------------Entry point
        PCin = 16'h28;
        //------------------------------------Run program
        repeat (11)
        begin
            //---------------------------------Fetch an ins
            clk = 1; #1;
            //---------------------------------Set control signals
            RegWrite = 0;
            ALUSrc = 1;
            op = 3'b010;
            // Add statements to adjust the above defaults
            // I used Figure 4.18 from the textbook as my guide plus Google Images lol - not sure if right

            if (ins[6:0] == 7'h33) // R-type
            begin
                $display("R-type");
                ALUSrc = 0;
                RegWrite = 1;
                op = 3'b010;
		if(ins[14:12] == 3'b110) // for R-Type that is or (funct3 is 110)
                    op = 3'b001;
            end
            else if (ins[6:0] == 7'h6F) // UJ-type
            begin
                $display("UJ-type");
                RegWrite = 1;
                ALUSrc = 1; // is NOT dont-care
                // op is dont-care or else set 0 if not working
            end
            else if (ins[6:0] == 7'h3) // lw (I-Type)
            begin
                $display("lw-type");
                ALUSrc = 1;
                RegWrite = 1;
            end
            else if (ins[6:0] == 7'h13) // addi (I-Type)
            begin
                $display("addi");
                ALUSrc = 1;
                RegWrite = 1;
            end
            else if (ins[6:0] == 7'h23) // sw (S-Type)
            begin
                $display("S-type");
                ALUSrc = 1;
                RegWrite = 0;
            end
            else if (ins[6:0] == 7'h63) // SB-Type beq
            begin
                $display("SB-type");
                ALUSrc = 0;
                RegWrite = 0;
                op = 3'b110;
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