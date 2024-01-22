module LabL1;
reg a, b, c, expect1, expect2;
wire z;
integer i, j, k;

yMux1 my_mux1(z, a, b, c);

initial
begin

for(i=0; i<4; i=i+1)
begin
    for(j=0; j<4; j=j+1)
    begin
        for(k=0; k<4; k=k+1)
        begin
        a=i; b=j; c=k;
        expect1 = (c==0) ? a[0]:b[0];
        expect2 = (c==0) ? a[1]:b[1];
        #1;
        if(expect1 === z[0] && expect2 === z[1])
            $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
        else
            $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
        end
    end
end
$finish;
end

endmodule
