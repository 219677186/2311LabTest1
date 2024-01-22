module labK;
reg [31:0] x; //32-bit register

initial
begin
    $display("$time = %5d, x = %b", x);
    x = 0;
    $display("$time = %5d, x = %b", x);
    x = x + 2;
    $display("$time = %5d, x = %b", x);
    $finish;
end

endmodule