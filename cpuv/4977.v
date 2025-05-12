module source #(
   parameter int unsigned RW=1,   
   parameter bit [RW-1:0] RP='0,  
   parameter bit [RW-1:0] RR='1   
)(
   input logic    clk,            
   input logic    rst,            
   handshake.src  inf,            
   output integer cnt             
);