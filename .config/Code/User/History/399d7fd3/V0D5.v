module LabM10;
  wire [5:0] fnCode;
  reg clk, INT;
  wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb, PCin;
  wire [25:0] jTarget;
  wire[2:0] op;
  reg [31:0] entryPoint;
  wire zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, jump, branch, rtype, lw, sw;
  wire [5:0] opCode;
  wire[1:0] ALUop;

  yIF my_IF(ins, PCp4, PCin, clk);
  yID my_ID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
  yEX my_Ex(z, zero, rd1, rd2, imm, op, ALUSrc);
  yDM my_DM(memOut, z, rd2, clk, MemRead, MemWrite);
  yWB my_WB(wb, z, memOut, Mem2Reg);
  assign wd = wb;

  yPC myPC(PCin, PCp4,INT,entryPoint,imm,jTarget,zero,branch,jump);
  assign opCode = ins[31:26];

  yC1 myC1(rtype, lw, sw, jump, branch, opCode);
  yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite,rtype, lw, sw, branch);
  assign fnCode = ins[5:0];

  yC3 myC3(ALUop, rtype, branch);
  yC4 myC4(op, ALUop, fnCode);
initial
  begin
    entryPoint = 32'h80; INT = 1'b1; #1;
    repeat(43)
    begin
    clk = 1'b1; #1 INT = 1'b0;
    clk = 1'b0;
    #1;
    $display("[0x%h-0x%h]rn1=%d rn2=%d rd1=%d rd2=%d imm=%h jTarget=%h z=%d zero=%h, wb=", PCin, ins, ins[25:21], ins[20:16], rd1, rd2, imm, jTarget, z, zero, wb);
  end
end

endmodule