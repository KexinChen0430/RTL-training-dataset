module wishbone_interconnect (
  clk,
  rst,
  i_m_we,    
  i_m_cyc,   
  i_m_sel,   
  i_m_stb,   
  o_m_ack,   
  i_m_dat,   
  o_m_dat,   
  i_m_adr,   
  o_m_int,   
  o_s0_we,   
  o_s0_cyc,  
  o_s0_sel,  
  o_s0_stb,  
  i_s0_ack,  
  o_s0_dat,  
  i_s0_dat,  
  o_s0_adr,  
  i_s0_int,  
  o_s1_we,   
  o_s1_cyc,  
  o_s1_sel,  
  o_s1_stb,  
  i_s1_ack,  
  o_s1_dat,  
  i_s1_dat,  
  o_s1_adr,  
  i_s1_int   
);
parameter ADDR_0    =   8'h00; 
parameter ADDR_1    =   8'h01; 
parameter ADDR_FF   =   8'hFF; 
input         clk;    
input         rst;    
input         i_m_we; 
input         i_m_stb; 
input         i_m_cyc; 
input  [3:0]  i_m_sel; 
input  [31:0] i_m_adr; 
input  [31:0] i_m_dat; 
output reg [31:0] o_m_dat = 32'h0; 
output reg       o_m_ack = 1'h0;   
output           o_m_int; 
output          o_s0_we;   
output          o_s0_stb;  
output          o_s0_cyc;  
output [3:0]    o_s0_sel;  
output [31:0]   o_s0_adr;  
output [31:0]   o_s0_dat;  
input  [31:0]   i_s0_dat;  
input           i_s0_ack;  
input           i_s0_int;  
output          o_s1_we;   
output          o_s1_stb;  
output          o_s1_cyc;  
output [3:0]    o_s1_sel;  
output [31:0]   o_s1_adr;  
output [31:0]   o_s1_dat;  
input  [31:0]   i_s1_dat;  
input           i_s1_ack;  
input           i_s1_int;  
wire [7:0] slave_select;
assign slave_select = i_m_adr[31:24]; 
wire [31:0] interrupts;
always @ (slave_select or i_s0_dat or i_s1_dat or interrupts) begin
    case (slave_select)
        ADDR_0: begin
            o_m_dat <= i_s0_dat; 
        end
        ADDR_1: begin
            o_m_dat <= i_s1_dat; 
        end
        default: begin
            o_m_dat <= interrupts;
        end
    endcase
end
always @ (slave_select or i_s0_ack or i_s1_ack) begin
    case (slave_select)
        ADDR_0: begin
            o_m_ack <= i_s0_ack; 
        end
        ADDR_1: begin
            o_m_ack <= i_s1_ack; 
        end
        default: begin
            o_m_ack <= 1'h0; 
        end
    endcase
end
assign interrupts[0]  = i_s0_int; 
assign interrupts[1]  = i_s1_int; 
assign interrupts[31:2] = 0; 
assign o_m_int  = (interrupts != 0); 
assign o_s0_we    = (slave_select == ADDR_0) ? i_m_we : 0;
assign o_s0_stb   = (slave_select == ADDR_0) ? i_m_stb : 0;
assign o_s0_sel   = (slave_select == ADDR_0) ? i_m_sel : 0;
assign o_s0_cyc   = (slave_select == ADDR_0) ? i_m_cyc : 0;
assign o_s0_adr   = (slave_select == ADDR_0) ? {8'h0 , i_m_adr[23:0]} : 0;
assign o_s0_dat   = (slave_select == ADDR_0) ? i_m_dat : 0;
assign o_s1_we    = (slave_select == ADDR_1) ? i_m_we : 0;
assign o_s1_stb   = (slave_select == ADDR_1) ? i_m_stb : 0;
assign o_s1_sel   = (slave_select == ADDR_1) ? i_m_sel : 0;
assign o_s1_cyc   = (slave_select == ADDR_1) ? i_m_cyc : 0;
assign o_s1_adr   = (slave_select == ADDR_1) ? {8'h0 , i_m_adr[23:0]} : 0;
assign o_s1_dat   = (slave_select == ADDR_1) ? i_m_dat : 0;
endmodule 