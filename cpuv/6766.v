module altgx_reconfig (  
	reconfig_clk,  
	reconfig_fromgxb,  
	busy,  
	error,  
	reconfig_togxb);  
	input	  reconfig_clk;  
	input	[16:0]  reconfig_fromgxb;  
	output	  busy;  
	output	  error;  
	output	[3:0]  reconfig_togxb;  
endmodule  