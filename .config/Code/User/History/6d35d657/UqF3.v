module labK;

reg a, b, cin;
wire z, cout;
integer i, j, k;
xor my_xor1(xorOutput1, a, b);
xor my_xor2(z, cin, xorInput2);
and my_and1(andOutput1, a, b);
and my_and2(andOutput2, xorInput2, cin);
or my_or(cout, or1, or2);

assign xorInput2 = xorOutput1;
assign or2 = andOutput1;
assign or1 = andOutput2;

initial
begin
    for(i=0; i<2; i=i+1)