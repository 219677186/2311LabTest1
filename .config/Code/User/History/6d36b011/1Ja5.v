module labM5;
reg clk, read, write;
reg[31:0] address, memIn;
wire[31:0] memOut;

mem data(memOut, address, memIn, clk, read, write);

initial
begin
    address = 16'h24;
    read = 1;
    write = 0;
    repeat(11)
    begin
        #4 $display("Address %d contains %h", address, memOut);
        address = address + 4;
    end
    $finish;
end

always
begin
    #4 clk = ~ clk;
end

endmodule