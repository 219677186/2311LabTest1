module LabL6;
reg [31:0] a, b;
wire [31:0] z;
reg cin;
wire cout;
reg ok;
reg[31:0] expect;

yAdder my_Adder(z, cout, a, b, cin);

initial
begin

    repeat(10)
    begin
        a = $random;
        b = $random;
        cin = $random;

        expect = a + b + cin;

        #1 ok = 0;

        #1;
        if(expect === z)
        begin
            ok = 1;
            $display("PASS: a=%b b=%b cin=%b z=%b cout=%b", a, b, cin, z, cout);
        end
        else
        begin
            ok = 0;
            $display("PASS: a=%b b=%b cin=%b z=%b cout=%b", a, b, cin, z, cout);
       end

end
$finish;
end

endmodule