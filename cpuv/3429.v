module UartTx(CLK, RST_X, DATA, WE, TXD, READY);
   input  wire        CLK, RST_X, WE; 
   input  wire [15:0] DATA; 
   output reg         TXD, READY; 
   reg [18:0]   cmd; 
   reg [11:0]   waitnum; 
   reg [4:0]    cnt; 
   always @(posedge CLK or negedge RST_X) begin
   if(~RST_X) begin 
   TXD       <= 1'b1; 
   READY     <= 1'b1; 
   cmd       <= 19'h7ffff; 
   waitnum   <= 0; 
   cnt       <= 0; 
        end else if( READY ) begin 
   TXD       <= 1'b1; 
   waitnum   <= 0; 
   if( WE )begin 
   READY <= 1'b0; 
   cmd   <= {DATA[15:8], 2'b01, 8'b11111111, 1'b1}; 
   cnt   <= 20;  
            end
        end else if( waitnum >= `SERIAL_WCNT ) begin 
   TXD       <= cmd[0]; 
   READY     <= (cnt == 1); 
   cmd       <= {1'b1, cmd[18:1]}; 
   waitnum   <= 1; 
   cnt       <= cnt - 1; 
        end else begin
   waitnum   <= waitnum + 1; 
        end
    end
   endmodule