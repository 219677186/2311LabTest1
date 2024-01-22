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
        cin = 0;

        expect = a + b + cin;

        #1 ok = (expect === z);

       



        #1;
        if(expect === z)
            $display("PASS: a0=%b a1=%b a2=%b a3=%b c=%b z=%b", a0, a1, a2, a3, c, z);
        else
            $display("FAIL: a0=%b a1=%b a2=%b a3=%b c=%b z=%b", a0, a1, a2, a3, c, z);
       

end
$finish;
end

endmodule