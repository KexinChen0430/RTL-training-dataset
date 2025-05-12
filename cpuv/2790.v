module ssi_sfifo
  #
  (
   parameter WIDTH = 32, 
   parameter DEPTH = 8,  
   parameter DLOG2 = 3,  
   parameter AFULL = 3   
   )
  (
   input  [WIDTH-1:0]     data, 
   input                  wrreq, 
   input                  rdreq, 
   input                  clock, 
   input                  aclr,  
   output reg [WIDTH-1:0] q,     
   output                 full,  
   output                 empty, 
   output reg [DLOG2-1:0] usedw, 
   output                 almost_full 
   );