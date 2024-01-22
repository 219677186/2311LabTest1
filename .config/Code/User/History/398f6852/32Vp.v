module LabL9;
reg [31:0] a, b, tmp;
reg [31:0] expect;
reg [2:0] op;
reg zero;
wire [31:0] z;
reg ok, flag;

yAlu mine(z, ex, a, b, op);

initial
begin
    repeat(10)
    begin
        a = $random;
        b = $random;
        tmp = $random % 2;
        if(tmp == 0) b = a;
        //Change depending on operation
        //op = $random;
        op = 111;
        flag = $value$plusargs("op=%d", op);

       // wire zero = (expect == 0) ? 1:0;

        case(op)
            3'b000: expect = a & b;
            3'b001: expect = a | b;
            3'b010: expect = a + b;
            3'b110: expect = a - b;
            3'b111: expect = (a<b)?1:0;

            default: expect = 32'b0;
        endcase

        zero = (expect == 0) ? 1:0;

        #1;

        ok = (z == expect);

        $display("TEST: a=%b, b=%b, op=%b, z=%b, expect=%b, ok=%b ex=%b", a, b, op, z, expect, ok);

        if(!ok) $finish;
    end
end

endmodule