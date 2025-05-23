module sasc_brg(   
   sio_ce, sio_ce_x4,          
   clk, arst_n                 
   );
   output          sio_ce;      
   output          sio_ce_x4;   
   input           clk;         
   input           arst_n;      
   reg             sio_ce;      
   reg             sio_ce_x4;   
   parameter       br_38400_16MHz = 103; 
`define BRX4pre &{brx4_cntr[6:5],brx4_cntr[2:0]} 
   reg [6:0]       brx4_cntr;   
   reg [1:0]       br_cntr;     
   always @ (posedge clk or negedge arst_n) 
     if (~arst_n)               
       brx4_cntr <= 0;          
     else if (`BRX4pre)         
       brx4_cntr <= 0;          
     else
       brx4_cntr <= brx4_cntr + 1'b1; 
   always @ (posedge clk or negedge arst_n) 
     if (~arst_n)               
       br_cntr <= 0;            
     else if (`BRX4pre)         
       br_cntr <= br_cntr + 1'b1; 
   always @ (posedge clk or negedge arst_n) 
     if (~arst_n)               
       begin
          sio_ce_x4 <= 1'b0;    
          sio_ce    <= 1'b0;    
       end
     else
       begin
          sio_ce_x4 <= `BRX4pre; 
          sio_ce    <= (&br_cntr) & (`BRX4pre); 
       end
endmodule 