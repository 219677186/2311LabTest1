module LabL4;
reg expect1, expect2;
parameter SIZE = 32;
output [31:0] z;
reg [31:0] a0, a1, a2, a3;
reg c;

yMux4to1 #(32) my_mux(z, a0, a1, a2, a3, c);

initial
begin

    repeat(10)
    begin
        a = $random;
        b = $random;
        c = $random % 2;
        expect1 = (c==0) ? a[0]:b[0];
        expect2 = (c==0) ? a[1]:b[1];
        #1;
        if(expect1 === z[0] && expect2 === z[1])
            $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
        else
            $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
       

end
$finish;
end

endmodule