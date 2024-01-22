module labk;
reg flag, a, b, c, exepct;
wire z;
integer i, j, k;
not my_not(notOutput, c);
and my_and1(andOutput1, a, lowerInput);
and my_and2(andOutput2, c, b);
or my_or(z, orInput1, orInput2);

assign lowerInput = notOutput;
assign orInput1 = andOutput1;
assign orInput2 = andOutput2;

initial
    begin
    flag = $value%plusargs("a=%b", a);
    flag = $value%plusargs("b=%b", b);
    flag = $value%plusargs("c=%b", c);
    a = i; b = j; c = k;
    exepct = (c&b)||(a&~c);
    #1;
    if(exepct === z)
    $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
    else
    $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
$finish;
end

endmodule