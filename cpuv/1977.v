module pipechecker(where, clk, req, res);
   parameter m = 32; 
   parameter n = 32; 
   input wire      clk; 
   input wire `REQ req; 
   input wire `RES res; 
   input wire [8*16:1] where; 
   wire   [m-1:0] addr; 
   wire           rd_strobe; 
   wire           wr_strobe; 
   wire   [n-1:0] wr_data; 
   wire [n/8-1:0] wr_byteena; 
   wire           hold; 
   wire   [n-1:0] rd_data; 