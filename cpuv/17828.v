module monitor(
	input sys_clk,             
	input sys_rst,             
	input write_lock,          
	input [31:0] wb_adr_i,     
	output reg [31:0] wb_dat_o,
	input [31:0] wb_dat_i,     
	input [3:0] wb_sel_i,      
	input wb_stb_i,            
	input wb_cyc_i,            
	output reg wb_ack_o,       
	input wb_we_i              
);
`ifdef CFG_GDBSTUB_ENABLED
reg [31:0] mem[0:2047];       
initial $readmemh("gdbstub.rom", mem); 
`else
reg [31:0] mem[0:511];        
initial $readmemh("monitor.rom", mem); 
`endif
`ifdef CFG_GDBSTUB_ENABLED
assign ram_we = (wb_adr_i[12] == 1'b1) | ~write_lock; 
wire [10:0] adr;             
assign adr = wb_adr_i[12:2]; 
`else
assign ram_we = (wb_adr_i[10:9] == 2'b11) | ~write_lock; 
wire [9:0] adr;              
assign adr = wb_adr_i[10:2]; 
`endif
always @(posedge sys_clk) begin
	wb_dat_o <= mem[adr];     
	if(sys_rst)               
		wb_ack_o <= 1'b0;     
	else begin                
		wb_ack_o <= 1'b0;     
		if(wb_stb_i & wb_cyc_i & ~wb_ack_o) begin 
			if(wb_we_i & ram_we) begin 
				if(wb_sel_i[0])
					mem[adr][7:0] <= wb_dat_i[7:0];
				if(wb_sel_i[1])
					mem[adr][15:8] <= wb_dat_i[15:8];
				if(wb_sel_i[2])
					mem[adr][23:16] <= wb_dat_i[23:16];
				if(wb_sel_i[3])
					mem[adr][31:24] <= wb_dat_i[31:24];
			end
			wb_ack_o <= 1'b1;   
		end
	end
end
endmodule