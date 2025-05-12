module t (
   i65, j65, i33, j33, i30, j30, q65, r65, q33, r33, q30, r30, w65, x65, w33,
   x33, w30, x30,
   a, a40, a70
   );
   input [3:0] a; 
   input [39:0] a40; 
   input [69:0] a70; 
   output [3:0] i65 = 65'd3 ** a; 
   output [3:0] j65 = a ** 65'd3; 
   output [3:0] i33 = 33'd3 ** a; 
   output [3:0] j33 = a ** 33'd3; 
   output [3:0] i30 = 30'd3 ** a; 
   output [3:0] j30 = a ** 30'd3; 
   output [39:0] q65 = 65'd3 ** a40; 
   output [39:0] r65 = a40 ** 65'd3; 
   output [39:0] q33 = 33'd3 ** a40; 
   output [39:0] r33 = a40 ** 33'd3; 
   output [39:0] q30 = 30'd3 ** a40; 
   output [39:0] r30 = a40 ** 30'd3; 
   output [69:0] w65 = 65'd3 ** a70; 
   output [69:0] x65 = a70 ** 65'd3; 
   output [69:0] w33 = 33'd3 ** a70; 
   output [69:0] x33 = a70 ** 33'd3; 
   output [69:0] w30 = 30'd3 ** a70; 
   output [69:0] x30 = a70 ** 30'd3; 
   initial begin
      $write("*-* All Finished *-*\n"); 
      $finish; 
   end
endmodule