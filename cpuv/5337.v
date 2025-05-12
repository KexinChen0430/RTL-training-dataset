module  stratixii_rublock 
	(
	clk, 
	shiftnld, 
	captnupdt, 
	regin, 
	rsttimer, 
	rconfig, 
	regout, 
	pgmout 
	);
	parameter operation_mode			= "remote"; 
	parameter sim_init_config			= "factory"; 
	parameter sim_init_watchdog_value	= 0; 
	parameter sim_init_page_select		= 0; 
	parameter sim_init_status			= 0; 
	parameter lpm_type					= "stratixii_rublock"; 
	input clk; 
	input shiftnld; 
	input captnupdt; 
	input regin; 
	input rsttimer; 
	input rconfig; 
	output regout; 
	output [2:0] pgmout; 
	reg [20:0] update_reg; 
	reg [4:0] status_reg; 
	reg [25:0] shift_reg; 
	reg [2:0] pgmout_update; 
	integer i; 
	initial
	begin
	end
	assign regout = shift_reg[0]; 
	assign pgmout = pgmout_update; 
	always @(clk)
	begin
	end
	always @(rconfig)
	begin
	end
endmodule