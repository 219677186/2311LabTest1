module labK;
reg [31:0] x, y, z;

initial
begin
    x = 5;
    $display("%2d: x=%1d y=%1d z=%1d, $time, x, y, z);
    y = x + 1;
    $display("%2d: x=%1d y=%1d z=%1d, $time, x, y, z);
    z = y + 1;
    $display("%2d: x=%1d y=%1d z=%1d, $time, x, y, z);
    $finish;
end

endmodule