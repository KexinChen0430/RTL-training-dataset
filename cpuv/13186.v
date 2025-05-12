module wishbone_interconnect (
  input               clk,        
  input               rst,        
  input               i_m_we,     
  input               i_m_stb,    
  input               i_m_cyc,    
  input       [3:0]   i_m_sel,    
  input       [31:0]  i_m_adr,    
  input       [31:0]  i_m_dat,    
  output reg  [31:0]  o_m_dat,    
  output reg          o_m_ack,    
  output              o_m_int,    
${PORTS}                          
);
${ADDRESSES}                       
parameter ADDR_FF = 8'hFF;        
wire [7:0] slave_select;          
wire [31:0] interrupts;           
assign slave_select = i_m_adr[31:24]; 
${DATA}                            
${ACK}                             
${INT}                             
assign o_m_int  = (interrupts != 0); 
${ASSIGN}                          
endmodule                          