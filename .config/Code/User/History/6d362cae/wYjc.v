module LabL1;
reg a, b, c, expect;
wire z;
integer i, j, k;

yMux1 my_mux1(z, a, b, c);

initial
begin

for(int i=0; i<2; i=i+1)
begin
    for(j=0; j<2; j=j+1)
    begin
        for(k=0; k<2; k=k+1)
        begin
        a=i; b=j; c=k;
        expect = (c==0) ? a:b;
        #1;
        if(expect === z)
            $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
        else
            $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
        end
    end
end
$finish;
end

endmodule