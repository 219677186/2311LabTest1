module LabL5;
reg[1:0] expect1, expect2;
output [1:0] z;
reg [1:0] a, b;
reg cin, cout;
integer i, j, k;

yAdder1 my_adder1(z, cout, a, b, cin);

initial
begin

for(i=0; i<2; i=i+1)
begin
    for(j=0; j<2; j=j+1)
    begin
        for(k=0; k<2; k=k+1)
        begin
        a=i; b=j; cin=k;
        expect1 = (a[0] + b[0] + cin);
        expect2 = (a[1]+b[1]+cin);
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