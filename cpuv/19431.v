module xx
  #(parameter X=4, 
    parameter Y=1) 
   (input clk, 
    input rstb, 
    input [X-1:0][1:0] xc, 
    input [X-1:0] xa, 
    input [X-1:0] xb, 
    input [X-1:0] cb, 
    output sometype_t [1:0]  st, 
    input [X*Y-1:0] yb, 
    output foobar 
    );
endmodule 