module ex_dram_emul ( MCLK, RST_N, IC_ACC, IDRAM_ADR, DC_ACC, DC_WR, DRAM_ADR, DRAM_DI,
                     IC_MDONE, DC_MDONE, ENWR, WAMUX, WADDR, MEM_Q, IWCTRL, DWCTRL );
input           MCLK;          
input           RST_N;         
input           IC_ACC;        
input   [27:0]  IDRAM_ADR;     
input           DC_ACC;        
input           DC_WR;         
input   [27:0]  DRAM_ADR;      
input   [35:0]  DRAM_DI;       
output  reg     IC_MDONE;      
output  reg     DC_MDONE;      
output          ENWR;          
output  reg     WAMUX;         
output  [11:2]  WADDR;         
output  reg  [2:0]  IWCTRL;    
output  reg  [2:0]  DWCTRL;    
output  reg  [31:0] MEM_Q;     
parameter addr_msb = 13;       
reg     [31:0] EDRAM [0:2**(addr_msb-1)-1]; 
reg  [addr_msb+34:0]  FIFO [0:15]; 
reg  [addr_msb+34:0]  fifo_q;      
reg          [1:0]    state;       
reg          [1:0]    nibble,lsb;  
reg  [addr_msb:4]     addr;        
reg                  use_cache;    
reg                  select;       
reg          [3:0]    w_poi,r_poi,r_zeiger; 
reg                  wr_next;      
wire [7:0]   din_0,din_1,din_2,din_3; 
wire [addr_msb:2]     raddr;       
wire                 frei;         
wire                 start;        
wire                 wr_req;       
wire                 ca_req;       
wire                 write;        
always @(negedge MCLK) if (DC_WR) FIFO[w_poi] <= {DRAM_ADR[addr_msb:2],DRAM_DI}; 
always @(posedge MCLK or negedge RST_N) 
    if (!RST_N) w_poi <= 4'd0;
        else w_poi <= w_poi + {3'd0,DC_WR};
always @(posedge MCLK or negedge RST_N) 
    if (!RST_N) r_poi <= 4'd0;
        else r_poi <= r_poi + {3'd0,write};
always @(negedge MCLK or negedge RST_N) 
    if (!RST_N) r_zeiger <= 4'd0;
        else r_zeiger <= r_zeiger + {3'd0,write};
always @(posedge MCLK) fifo_q <= FIFO[r_zeiger]; 
always @(negedge MCLK) MEM_Q <= EDRAM[raddr];    
assign din_0 = fifo_q[32] ? fifo_q[7:0]   : MEM_Q[7:0];   
assign din_1 = fifo_q[33] ? fifo_q[15:8]  : MEM_Q[15:8];
assign din_2 = fifo_q[34] ? fifo_q[23:16] : MEM_Q[23:16];
assign din_3 = fifo_q[35] ? fifo_q[31:24] : MEM_Q[31:24];
always @(posedge MCLK) if (write) EDRAM[raddr] <= {din_3,din_2,din_1,din_0}; 
assign ca_req = DC_ACC | IC_ACC;    
assign wr_req = (w_poi != r_poi);   
assign write = (wr_req & ~ca_req & frei) | wr_next; 
always @(posedge MCLK or negedge RST_N) 
    if (!RST_N) wr_next <= 1'b0;
        else wr_next <= write & (w_poi != (r_poi + 4'd1));
always @(posedge MCLK or negedge RST_N) 
    if (!RST_N) state <= 2'd0;
      else
        if (frei) state <= (ca_req & ~wr_next) ? 2'b01 : 2'd0;
          else state <= state + 2'b01;
assign frei = (state == 2'd0); 
assign start = ca_req & frei & ~wr_next; 
always @(negedge MCLK) 
    if (start)
        begin
            addr       <= DC_ACC ? DRAM_ADR[addr_msb:4] : IDRAM_ADR[addr_msb:4];
            use_cache  <= DC_ACC ? DRAM_ADR[1] : IDRAM_ADR[1];
            select     <= DC_ACC;
        end
always @(negedge MCLK) 
    if (start) nibble <= DC_ACC ? {DRAM_ADR[3],~DRAM_ADR[2]} : {IDRAM_ADR[3],~IDRAM_ADR[2]};
      else
        if (state == 2'b01) nibble <= {~nibble[1],1'b0};
          else
            if (state[1]) nibble <= {nibble[1],~nibble[0]};
assign raddr = write ? fifo_q[addr_msb+34:36] : (start ? (DC_ACC ? DRAM_ADR[addr_msb:2] : IDRAM_ADR[addr_msb:2]) : {addr,nibble}); 
always @(negedge MCLK) lsb <= raddr[3:2]; 
assign ENWR = 1'b1;    
always @(posedge MCLK) 
    begin
      WAMUX    <= start | ~frei;
      DC_MDONE <=  select & (state == 2'b01);
      DWCTRL[2] <=  select &  start;
      DWCTRL[1] <=  select & (start | ~frei) & use_cache;
      DWCTRL[0] <=  select & ~use_cache;
      IC_MDONE <= ~select & (state == 2'b10); 
      IWCTRL[2] <= ~select &  start;
      IWCTRL[1] <= ~select & (start | ~frei) & use_cache;
      IWCTRL[0] <= ~select & ~use_cache;
    end
assign WADDR = {addr[11:4],lsb}; 
endmodule