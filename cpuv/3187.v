module v93adf6_vb8adf8 #( 
 parameter INI = 0 
) (
 input clk, 
 input d, 
 input load, 
 output q 
);
 reg q = INI; 
 always @(posedge clk)
   if (load) 
     q <= d; 
endmodule 