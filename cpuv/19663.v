module yy
  #(parameter X=4, 
    parameter Y=1) 
   (input clk, 
    input rstb, 
    output [X-1:0][1:0] xc, 
    output [X-1:0] xa, 
    input [X-1:0] xb, 
    input [X-1:0] cb, 
    input sometype_t [1:0] st, 
    output [X*Y-1:0] yb, 
    output [4:0][2:0] foobar2 
    );
endmodule