module initiator
  (input  wire        clk,       
   input  wire        rst,       
   output reg  `REQ   req,       
   input  wire `RES   res);      
   reg [31:0] counter;           
   reg [31:0] dataExpect;        
   reg        dataValid;         
   always @(posedge clk)
     if (rst) begin              
        counter <= 0;            
        req     <= 0;            
        dataValid <= 0;          
        dataExpect <= 0;         
     end else begin              
        dataValid <= req`R & ~res`WAIT;
        if (dataValid) begin     
           if (dataExpect != res`RD)
             $display("%6d Main got %x !!! BAD!", $time, res`RD);
        end
        if (~res`WAIT) begin
           req`R   <= 1;         
           req`A   <= counter;   
           dataExpect <= req`A;  
           counter <= counter + 1; 
        end
     end
endmodule