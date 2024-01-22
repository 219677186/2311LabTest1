module labK;

reg a, b, cin;
wire z, cout;
integer i, j, k;
xor my_xor1(xorOutput1, a, b);
xor my_xor2(z, cin, xorInput2);
and my_and1(andOutput1, a, b);
and my_and2(andOutput2, xorInput2, cin);
or my_or(cout, orFinal1, orFinal2);