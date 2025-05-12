module stratix_jtag (
    tms,         
    tck,         
    tdi,         
    ntrst,       
    tdoutap,     
    tdouser,     
    tdo,         
    tmsutap,     
    tckutap,     
    tdiutap,     
    shiftuser,    
    clkdruser,    
    updateuser,   
    runidleuser,  
    usr1user      
);
input tms;
input tck;
input tdi;
input ntrst;
input tdoutap;
input tdouser;
output tdo;
output tmsutap;
output tckutap;
output tdiutap;
output shiftuser;
output clkdruser;
output updateuser;
output runidleuser;
output usr1user;
parameter lpm_type = "stratix_jtag";
endmodule