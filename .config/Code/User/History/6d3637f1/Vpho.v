module LabL4;
reg expect1, expect2, expect3, expect4;
parameter SIZE = 32;
output [31:0] z;
reg [31:0] a0, a1, a2, a3;
reg [1:0]c;

yMux4to1 #(32) my_mux(z, a0, a1, a2, a3, c);

initial
begin

    repeat(10)
    begin
        a0 = $random;
        a1 = $random;
        a2 = $random;
        a3 = $random;
        c = $random % 2;
        expect1 = (c==0) ? a0[0]:a1[0];
        expect2 = (c==0) ? a0[1]:a1[1];
        #1;
        if(expect1 === z[0] && expect2 === z[1])
            $display("PASS: a0=%b a1=%b a2=%b a3=%b c=%b z=%b", a0, a1, a2, a3, c, z);
        else
            $display("FAIL: a0=%b a1=%b a2=%b a3=%b c=%b z=%b", a0, a1, a2, a3, c, z);
       

end
$finish;
end

endmodule