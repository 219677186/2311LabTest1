module labM4;
reg [31:0] address, memIn;
reg clk, memRead, memWrite;
wire [31:0] memOut;

mem data(memOut, address, memIn, clk, memRead, memWrite);

initial
begin
    memWrite = 1;
    memRead = 0;
    address = 16;
    clk = 0;
    memIn = 32'h12345678;
    #4 memRead = 1;
    #1 $display("Address %d contains %h", address, memOut);
    address = address + 4;
    #4 memRead = 0;
    #1 $display("Address %d contains %h", address, memOut);
    #4;
    address = 16;
    memRead = 1;
    memWrite = 0;
    
    repeat(3)
    begin
        #4 $display("Address %d contains %h", address, memOut);
        address = address + 4;
    end
    $finish;
    end
always
begin
    #4 clk = ~clk;
end

endmodule