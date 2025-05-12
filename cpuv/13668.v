module  stratixiii_tsdblock 
	(
        offset, 
        clk, 
        ce, 
        clr, 
        testin, 
        tsdcalo, 
        tsdcaldone, 
        fdbkctrlfromcore, 
        compouttest, 
        tsdcompout, 
        offsetout 
	);
input [5:0] offset; 
input [7:0] testin; 
input clk; 
input ce; 
input clr; 
input fdbkctrlfromcore; 
input compouttest; 
output [7:0] tsdcalo; 
output tsdcaldone; 
output tsdcompout; 
output [5:0] offsetout; 
parameter poi_cal_temperature = 85; 
parameter clock_divider_enable = "on"; 
parameter clock_divider_value = 40; 
parameter sim_tsdcalo = 0; 
parameter user_offset_enable = "off"; 
parameter lpm_type = "stratixiii_tsdblock"; 
endmodule 