module drain #(
   parameter int unsigned RW=1,   
   parameter bit [RW-1:0] RP='0,  
   parameter bit [RW-1:0] RR='1   
)(
   input logic    clk,            
   input logic    rst,            
   handshake.drn  inf,            
   output integer cnt             
);
   logic [RW-1:0] rnd;            
   always @ (posedge clk, posedge rst) 
   if (rst) rnd <= RR;                 
   else     rnd <= {rnd[0], rnd[RW-1:1]} ^ ({RW{rnd[0]}} & RP); 
   always @ (posedge clk, posedge rst) 
   if (rst) cnt <= 32'd0;              
   else     cnt <= cnt + {31'd0, (inf.req & inf.grt)}; 
   assign inf.grt = rnd[0];            
endmodule