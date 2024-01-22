module LabL5;
reg[1:0] expect1, expect2;
output z;
reg a, b;
reg cin;
output cout;
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
        expect1 = (a^b^cin);
        /*expect2 = (a[1]^b[1]^cin);*/
        #1;
        if(expect1 === z) /*  && expect2 === z[1])*/
            $display("PASS: a=%b b=%b cin=%b z=%b", a, b, cin, z);
        else
            $display("FAIL: a=%b b=%b cin=%b z=%b", a, b, cin, z);
        end
    end
end
$finish;
end

endmodule