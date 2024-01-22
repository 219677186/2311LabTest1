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
        tmp = $random % 2;
        if(tmp == 0) b = a;
        //Change depending on operation
        //op = $random;
        op = 111;
        flag = $value$plusargs("op=%d", op);

        case(op)
            3'b000: expect = a & b;
            3'b001: expect = a | b;
            3'b010: expect = a + b;
            3'b110: expect = a - b;
            3'b111: expect = (a<b)?1:0;
            default: expect = 32'b0;
        endcase

        #1;

        ok = (z == expect);

        $display("TEST: a=%b, b=%b, op=%b, z=%b, expect=%b, ok=%b", a, b, op, z, expect, ok);

        if(!ok) $finish;
    end
end

endmodule