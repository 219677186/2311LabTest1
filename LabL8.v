module LabL8;
reg signed [31:0] a, b;
reg signed [31:0] expect;
reg cin, ctrl;
reg ok;
wire [31:0] z;
wire cout;

yArith my_Arith(z, cout, a, b, ctrl);
initial
begin
    repeat(10)
    begin
        a = $random;
        b = $random;
        ctrl = $random % 2;
        cin = 0;

        expect = (ctrl == 0) ? a + b + cin: a - b - cin;
        #1ok = 0;

        #1;
        if(expect === z)
        begin
            ok = 1;
            $display("PASS: a=%b b=%b ctrl=%b z=%b cout=%b", a, b, ctrl, z, cout);
        end
        else
        begin
            ok = 0;
            $display("FAIL: a=%b b=%b ctrl=%b z=%b cout=%b", a, b, ctrl, z, cout);
       end
    end
    $finish;
end

endmodule