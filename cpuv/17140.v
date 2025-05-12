module buffer_unit(
  input clock,                          
  input reset,                          
  input shift,                          
  input [`CAMERA_PIXEL_BITWIDTH:0] in,  
  output reg [`CAMERA_PIXEL_BITWIDTH:0] out 
);
  always@(posedge clock or negedge reset) begin
    if(reset == 1'b0)                     
      out <= `CAMERA_PIXEL_WIDTH'd0;      
    else if(shift)                        
      out <= in;                          
    else                                  
      out <= out;                         
  end 
endmodule 