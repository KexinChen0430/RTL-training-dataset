module premuat_16( 
            enable, 
		       inverse, 
               i_0, 
               i_1, 
               i_2, 
               i_3, 
               i_4, 
               i_5, 
               i_6, 
               i_7, 
               i_8, 
               i_9, 
               i_10, 
               i_11, 
               i_12, 
               i_13, 
               i_14, 
               i_15, 
               o_0, 
               o_1, 
               o_2, 
               o_3, 
               o_4, 
               o_5, 
               o_6, 
               o_7, 
               o_8, 
               o_9, 
               o_10, 
               o_11, 
               o_12, 
               o_13, 
               o_14, 
               o_15 
);
input                enable; 
input               inverse; 
input  signed  [27:0]   i_0; 
output  signed [27:0]   o_0; 
reg  signed [27:0]   o1; 
always@(*) 
if(inverse) 
  begin
     o1 =i_2; 
     o2 =i_4; 
   end
 else 
   begin
     o1 =i_8; 
     o2 =i_1; 
   end
assign  o_0=i_0; 
assign  o_1=enable?o1:i_1; 
assign  o_15=i_15; 
endmodule 