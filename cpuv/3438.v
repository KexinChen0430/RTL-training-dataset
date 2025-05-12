module UartTx(CLK, RST_X, DATA, WE, TXD, READY);
   input wire  CLK, RST_X, WE;       
   input wire [7:0] DATA;            
   output reg  TXD, READY;           
   reg [8:0]   cmd;                  
   reg [11:0]  waitnum;              
   reg [3:0]   cnt;                  
   always @(posedge CLK or negedge RST_X) begin
      if(~RST_X) begin               
         TXD       <= 1'b1;          
         READY     <= 1'b1;          
         cmd       <= 9'h1FF;        
         waitnum   <= 0;             
         cnt       <= 0;             
      end else if( READY ) begin     
         TXD       <= 1'b1;          
         waitnum   <= 0;             
         if( WE )begin               
            READY <= 1'b0;           
            cmd   <= {DATA, 1'b0};   
            cnt   <= 10;             
         end
      end else if( waitnum >= `SERIAL_WCNT ) begin 
         TXD       <= cmd[0];        
         READY     <= (cnt == 1);    
         cmd       <= {1'b1, cmd[8:1]}; 
         waitnum   <= 1;             
         cnt       <= cnt - 1;       
      end else begin                 
         waitnum   <= waitnum + 1;   
      end
   end
endmodule