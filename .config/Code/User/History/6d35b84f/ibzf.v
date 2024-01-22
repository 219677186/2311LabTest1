module labK;
reg [31:0] x; //32-bit register

initial
begin
    $display("$time = %5d, x = %b", $time, x);
    x = 32'hffff0000;
    $display("$time = %5d, x = %b", $time, x);
    x = x + 2;
    $display("$time = %5d, x = %b", $time, x);
    $finish;
end

endmodule