module labK;
reg a, b; //reg without size means 1-bit
wire notOutput, lowerOutput, tmp, z;

not my_not(notOutput, b);
and my_and(z, a, lowerOutput);
assign lowerOutput = notOutput;

initial
begin
    a = 1; b = 1;
    $display("a=%b b=%b z=%b", a, b, z);
    $finish;
end

endmodule