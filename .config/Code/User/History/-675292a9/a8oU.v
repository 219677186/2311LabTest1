/*module yMux2(z, a, b, c);*/
module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;

/*For LabL2.v*/
/*yMux1 upper(z[0], a[0], b[0], c);*/
/*yMux1 lower(z[1], a[1], b[1], c);*/

/*For LabL3.v*/
yMux1 mine[SIZE-1:0](z, a, b, c);

endmodule