module comm_fpga_epp(
	input  wire      clk_in,          
	input  wire      reset_in,        
	output reg       reset_out,       
	inout  wire[7:0] eppData_io,      
	input  wire      eppAddrStb_in,   
	input  wire      eppDataStb_in,   
	input  wire      eppWrite_in,     
	output wire      eppWait_out,     
	output wire[6:0] chanAddr_out,    
	output reg[7:0]  h2fData_out,     
	output reg       h2fValid_out,    
	input  wire      h2fReady_in,     
	input  wire[7:0] f2hData_in,      
	input  wire      f2hValid_in,     
	output reg       f2hReady_out     
);