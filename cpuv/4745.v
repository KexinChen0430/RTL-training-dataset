module system_affine_transform_0_1(
  a00, a01, a10, a11, 
  x_in, x_out,        
  y_in, y_out         
)
;
  input [31:0]a00; 
  input [31:0]a01; 
  input [31:0]a10; 
  input [31:0]a11; 
  input [9:0]x_in;  
  output [9:0]x_out; 
  input [9:0]y_in;  
  output [9:0]y_out; 
endmodule