module labK;
reg [31:0] x, y, z;

initial
initial
    #15 x = x + 1
begin
    #10 x = 5;
    $display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
    #10 y = x + 1;
    $display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
    #10 z = y + 1;
    $display("%2d: x=%1d y=%1d z=%1d", $time, x, y, z);
    $finish;
end

endmodule