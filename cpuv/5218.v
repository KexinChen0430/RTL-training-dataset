module sro
  #(parameter DATA_WIDTH=16) 
  (input clk,                
   input resetb,             
   input shift,              
   input dout,               
   output reg [DATA_WIDTH-1:0] datao 
   );
   reg dout_s; 