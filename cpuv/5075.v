module pixel_processing(
  clk,             
  in_blank,        
  in_hsync,        
  in_vsync,        
  in_red,          
  in_green,        
  in_blue,         
  is_interlaced,   
  is_second_field, 
  audio_channel,   
  audio_de,        
  audio_sample,    
  switches,        
  out_blank,       
  out_hsync,       
  out_vsync,       
  out_red,         
  out_green,       
  out_blue         
);
  input [2:0] audio_channel;
  input audio_de;
  input [23:0] audio_sample;
  input clk;
  input in_blank;
  input [7:0] in_blue;
  input [7:0] in_green;
  input in_hsync;
  input [7:0] in_red;
  input in_vsync;
  input is_interlaced;
  input is_second_field;
  output out_blank;
  output [7:0] out_blue;
  output [7:0] out_green;
  output out_hsync;
  output [7:0] out_red;
  output out_vsync;
  input [7:0] switches;
  assign out_blank = 1'hz;   
  assign out_hsync = 1'hz;   
  assign out_vsync = 1'hz;   
  assign out_red = 8'hzz;    
  assign out_green = 8'hzz;  
  assign out_blue = 8'hzz;   
endmodule