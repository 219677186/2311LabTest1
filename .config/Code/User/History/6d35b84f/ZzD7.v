module labK;
reg [31:0] x; //32-bit register

initial
begin
    $display($time, " ", x);
    x = 0;
    $display($time, " ", x);
    x = x + 2;
    $display($time, " ", x);
    finish;
end

endmodule