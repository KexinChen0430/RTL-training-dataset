module ${ARBITER_NAME} (
  input           clk,            
  input           rst,            
${PORTS}
  output          o_s_we,         
  output          o_s_stb,        
  output          o_s_cyc,        
  output  [3:0]   o_s_sel,        
  output  [31:0]  o_s_adr,        
  output  [31:0]  o_s_dat,        
  input   [31:0]  i_s_dat,        
  input           i_s_ack,        
  input           i_s_int         
);
localparam        MASTER_COUNT = ${NUM_MASTERS};
reg [7:0]         master_select;      
reg [7:0]         priority_select;    
wire              o_master_we  [MASTER_COUNT - 1:0];  
wire              o_master_stb [MASTER_COUNT - 1:0];  
wire              o_master_cyc [MASTER_COUNT - 1:0];  
wire  [3:0]       o_master_sel [MASTER_COUNT - 1:0];  
wire  [31:0]      o_master_adr [MASTER_COUNT - 1:0];  
wire  [31:0]      o_master_dat [MASTER_COUNT - 1:0];  
${MASTER_SELECT}
${PRIORITY_SELECT}
assign  o_s_we  = (master_select != MASTER_NO_SEL) ? o_master_we[master_select]  : 0;
assign  o_s_stb = (master_select != MASTER_NO_SEL) ? o_master_stb[master_select] : 0;
assign  o_s_cyc = (master_select != MASTER_NO_SEL) ? o_master_cyc[master_select] : 0;
assign  o_s_sel = (master_select != MASTER_NO_SEL) ? o_master_sel[master_select] : 0;
assign  o_s_adr = (master_select != MASTER_NO_SEL) ? o_master_adr[master_select] : 0;
assign  o_s_dat = (master_select != MASTER_NO_SEL) ? o_master_dat[master_select] : 0;
${WRITE}
${STROBE}
${CYCLE}
${SELECT}
${ADDRESS}
${DATA}
${ASSIGN}
endmodule