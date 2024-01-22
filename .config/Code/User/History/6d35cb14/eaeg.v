module labk;
reg a, b, c, exepct;
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
    for(i=0; i<2; i=i+1)
        begin
            for(j=0; j<2; j=j+1)
                begin
                for(k=0; k<2; k=k+2)
                begin
                a=i; b=j; c=k;
                exepct = (c&b)||(a&~c);
                #1;
                if(exepct === z)
                 $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
                else
                 $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
            end
        end
    end
$finish;
end

endmodule