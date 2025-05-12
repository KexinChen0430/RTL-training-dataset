module arriaiigz_jtag (
    input tms,          
    input tck,          
    input tdi,          
    input ntrst,        
    input tdoutap,      
    input tdouser,      
    output tdo,         
    output tmsutap,     
    output tckutap,     
    output tdiutap,     
    output shiftuser,   
    output clkdruser,   
    output updateuser,  
    output runidleuser, 
    output usr1user     
    parameter lpm_type = "arriaiigz_jtag"
);
endmodule