module sram16_ctrl
   (input  wire        clock,              
   ,input  wire        rst,                
   ,output             mem_waitrequest,    
   ,input        [1:0] mem_id,             
   ,input       [29:0] mem_address,        
   ,input              mem_read,           
   ,input              mem_write,          
   ,input       [31:0] mem_writedata,      
   ,input        [3:0] mem_writedatamask,  
   ,output reg  [31:0] mem_readdata,       
   ,output reg   [1:0] mem_readdataid = 0, 
   ,output reg  [29:0] sram_a,             
   ,inout  wire [15:0] sram_d,             
   ,output reg         sram_cs_n = 1,      
   ,output reg   [1:0] sram_be_n,          
   ,output reg         sram_oe_n = 1,      
   ,output reg         sram_we_n = 1       
   );
parameter wait_cycles  = 5;               
parameter burst_length = 4;               
parameter CNTSIGN  = 4;                   
parameter WAITSIGN = 4;                   
parameter S_IDLE     = 0;                 
parameter S_WRITE1   = 1;                 
parameter S_WRITE2   = 2;                 
parameter S_WRITE3   = 3;                 
parameter S_PAUSE    = 4;                 
reg [ 2:0] state     = S_IDLE;            
wire       sel       = mem_address[29:26] == 'h4; 
reg [CNTSIGN:0] cnt      = ~0;            
reg        int_we_n  = 1;                 
reg [ 1:0] pendingid;                     
reg [31:0] sram_dout;                     
reg [15:0] writedata_hi;                  
reg [ 1:0] be_n_hi;                       
reg [WAITSIGN:0] waitcnt = ~0;            
assign mem_waitrequest   = state != S_IDLE || !cnt[CNTSIGN] || !waitcnt[WAITSIGN];
reg       sram_dout_en      = 0;          
assign    sram_d            = sram_dout_en ? sram_dout : 'hZ; 
always @(negedge clock)
   sram_we_n <= int_we_n;
always @(posedge clock) begin
   mem_readdataid <= 0;                    
   if (!waitcnt[WAITSIGN])                 
      waitcnt <= waitcnt - 1'd1;           
   else
      case (state)                         
      S_IDLE:                              
         if (!cnt[CNTSIGN]) begin          
            waitcnt             <= wait_cycles - 1'd1; 
            cnt                 <= cnt - 1;            
            sram_a              <= sram_a + 1'd1;      
            mem_readdata[31:16] <= sram_d;             
            mem_readdata[15: 0] <= mem_readdata[31:16];
            if (sram_a[0])                              
               mem_readdataid <= pendingid;             
         end else if (mem_read) begin                   
            waitcnt      <= wait_cycles - 1'd1;         
            pendingid    <= mem_id;                     
            sram_a       <= mem_address << 1;           
            sram_cs_n    <= 0;                          
            sram_oe_n    <= 0;                          
            sram_be_n    <= 0;                          
            int_we_n     <= 1;                          
            sram_dout_en <= 0;                          
            cnt          <= (burst_length << 1) - 1;    
         end else if (mem_write) begin                  
            waitcnt                  <= wait_cycles - 1'd1; 
            sram_a                   <= mem_address << 1;   
            sram_dout_en             <= 1;                  
            {writedata_hi,sram_dout[15:0]} <= mem_writedata; 
            {be_n_hi,sram_be_n[1:0]}      <= ~mem_writedatamask; 
            sram_cs_n                <= 0;                  
            sram_oe_n                <= 1;                  
            int_we_n                 <= 0;                  
            state                    <= S_WRITE1;           
         end else begin                                   
            sram_cs_n    <= 1;                            
            sram_oe_n    <= 1;                            
            sram_dout_en <= 0;                            
            int_we_n     <= 1;                            
         end
      S_WRITE1: begin                                     
         int_we_n  <= 1;                                  
         state     <= S_WRITE2;                           
      end
      S_WRITE2: begin                                     
         waitcnt   <= wait_cycles - 1'd1;                 
         sram_a[0] <= 1;                                  
         sram_dout <= writedata_hi;                       
         sram_be_n <= be_n_hi;                            
         int_we_n  <= 0;                                  
         state     <= S_WRITE3;                           
      end
      S_WRITE3: begin                                     
         int_we_n  <= 1;                                  
         state     <= S_IDLE;                             
      end
      S_PAUSE: begin                                      
         sram_cs_n <= 1;                                  
         waitcnt   <= wait_cycles - 1'd1;                 
         state     <= S_IDLE;                             
      end
      endcase
   end
`define DEBUG_SRAM 1
`ifdef DEBUG_SRAM
   always @(negedge clock)
         $display("%05d  SRAM cs# %x a %x d %x we# %x oe# %x", $time,
                  sram_cs_n, sram_a, sram_d, sram_we_n, sram_oe_n);
   always @(posedge clock) begin
      if (!mem_waitrequest & sel & mem_read)
         $display("%05d  sram[%x] -> ? for %d", $time,
                  {mem_address,2'd0}, mem_id);
      if (!mem_waitrequest & sel & mem_write)
         $display("%05d  sram[%x] <- %8x/%x", $time,
                  {mem_address,2'd0}, mem_writedata, mem_writedatamask);
      if (mem_readdataid)
         $display("%05d  sram[%x] -> %8x for %d", $time,
                  32'h3fff_fffc + (sram_a << 2), mem_readdata, mem_readdataid);
      $display("%05d  SRAM cs# %x a %x d %x we# %x oe# %x", $time,
               sram_cs_n, sram_a, sram_d, sram_we_n, sram_oe_n);
   end
`endif
endmodule