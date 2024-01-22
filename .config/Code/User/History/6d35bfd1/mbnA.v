module labK;
reg a, b; //reg without size means 1-bit
wire notOutput, lowerOutput, tmp, z;

not my_not(notOutput, b);
assign lowerOutput = notOutput;
and my_and(z, a, lowerOutput);

initial
begin
    #1 a = 1; b = 1;
    $display("a=%b b=%b z=%b", a, b, z);
    $finish;
end

endmodule