module wishbone_mem_interconnect (
	clk,                
	rst,                
	i_m_we,             
	i_m_cyc,            
	i_m_stb,            
	i_m_sel,            
	o_m_ack,            
	i_m_dat,            
	o_m_dat,            
	i_m_adr,            
	o_m_int,            
	o_s0_we,            
	o_s0_cyc,           
	o_s0_stb,           
	o_s0_sel,           
	i_s0_ack,           
	o_s0_dat,           
	i_s0_dat,           
	o_s0_adr,           
	i_s0_int            
);
localparam MEM_SEL_0    = 0;          
localparam MEM_OFFSET_0 = 0;          
localparam MEM_SIZE_0   = 4096;       
input                   clk;          
input                   rst;          
input                   i_m_we;       
input                   i_m_stb;      
input                   i_m_cyc;      
input       [3:0]       i_m_sel;      
input       [31:0]      i_m_adr;      
input       [31:0]      i_m_dat;      
output reg  [31:0]      o_m_dat;      
output reg              o_m_ack;      
output reg              o_m_int;      
output                  o_s0_we;      
output                  o_s0_cyc;     
output                  o_s0_stb;     
output      [3:0]       o_s0_sel;     
output      [31:0]      o_s0_adr;     
output      [31:0]      o_s0_dat;     
input       [31:0]      i_s0_dat;     
input                   i_s0_ack;     
input                   i_s0_int;     
reg [31:0] mem_select;
always @(rst or i_m_adr or mem_select) begin
	if (rst) begin
		mem_select <= 32'hFFFFFFFF; 
	end
	else begin
		if ((i_m_adr >= MEM_OFFSET_0) && (i_m_adr < (MEM_OFFSET_0 + MEM_SIZE_0))) begin
			mem_select <= MEM_SEL_0; 
		end
		else begin
			mem_select <= 32'hFFFFFFFF; 
		end
	end
end
always @ (mem_select or i_s0_dat) begin
	case (mem_select)
		MEM_SEL_0: begin
			o_m_dat <= i_s0_dat; 
		end
		default: begin
			o_m_dat <= 32'h0000; 
		end
	endcase
end
always @ (mem_select or i_s0_ack) begin
	case (mem_select)
		MEM_SEL_0: begin
			o_m_ack <= i_s0_ack; 
		end
		default: begin
			o_m_ack <= 1'h1; 
		end
	endcase
end
always @ (mem_select or i_s0_int) begin
	case (mem_select)
		MEM_SEL_0: begin
			o_m_int <= i_s0_int; 
		end
		default: begin
			o_m_int <= 1'h0; 
		end
	endcase
end
assign o_s0_we  = (mem_select == MEM_SEL_0) ? i_m_we : 0;  
assign o_s0_stb = (mem_select == MEM_SEL_0) ? i_m_stb : 0; 
assign o_s0_sel = (mem_select == MEM_SEL_0) ? i_m_sel : 0; 
assign o_s0_cyc = (mem_select == MEM_SEL_0) ? i_m_cyc : 0; 
assign o_s0_adr = (mem_select == MEM_SEL_0) ? i_m_adr : 0; 
assign o_s0_dat = (mem_select == MEM_SEL_0) ? i_m_dat : 0; 
endmodule