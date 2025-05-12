module sub
  (
   output outvar, 
   input wire scalar_var, 
   input wire [1:0] packed1_var, 
   input wire [1:0][2:0] packed2_var, 
   input wire [1:0] packed1_unpacked1_var [2], 
   input wire [1:0] packed1_unpacked2_var [2][3], 
   input wire [1:0][2:0] packed2_unpacked1_var [2], 
   input wire [1:0][2:0] packed2_unpacked2_var [2][3], 
   input wire unpacked1_var [2] 
   input wire unpacked2_var [2][3] 
   );
endmodule 