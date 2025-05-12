module vc_ResetReg 
#(
  parameter p_nbits       = 1, 
  parameter p_reset_value = 0  
)(
  input                clk,   
  input                reset, 
  output [p_nbits-1:0] q,     
  input  [p_nbits-1:0] d      
);
  reg q; 
  always @( posedge clk ) 
    q <= reset ? p_reset_value : d; 
endmodule 