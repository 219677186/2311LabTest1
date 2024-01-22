module LabL9;
reg [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;

yAlu mine(z, ex, a, b, op);

initial
begin
    repeat(10)
    begin
        a = $random;
        b = $random;
        flag = $value$plusargs("op=%d", op);

        /*case(op)
            3'b000: z = a & b;
            3'b001: z = a | b;
            3'b010: z = a + b;
            3'b110: z = a - b;
            def: expect = 32'b0;
        endcase*/

        #1;

        ok = (z == expect);

        $display("TEST %0d: a=%0d, b=%0d, op=%b, z=%0d, expect=%0d, ok=%b", $iteration, a, b, op, z, expect, ok);

        if(!ok) $finish;
    end
end

endmodule