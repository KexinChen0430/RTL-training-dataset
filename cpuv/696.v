module sync_r2w #(parameter ADDRSIZE = 3) 
  (
   output reg [ADDRSIZE:0] wq2_rptr, 
   input [ADDRSIZE:0] rptr,          
   input wclk,                       
   input wrst_n                      
  );
   reg [ADDRSIZE:0] wq1_rptr;
   always @(posedge wclk or negedge wrst_n)
     if (!wrst_n) 
       {wq2_rptr,wq1_rptr} <= 0; 
     else 
       {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr}; 
endmodule 