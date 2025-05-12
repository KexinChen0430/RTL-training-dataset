module cycloneiiils_rublock
    (
    clk,                
    shiftnld,           
    captnupdt,          
    regin,              
    rsttimer,           
    rconfig,            
    regout              
    );
    parameter sim_init_config = "factory";          
    parameter sim_init_watchdog_value = 0;          
    parameter sim_init_status = 0;                  
    parameter lpm_type = "cycloneiiils_rublock";    
    input clk;          
    input shiftnld;     
    input captnupdt;    
    input regin;        
    input rsttimer;     
    input rconfig;      
    output regout;      
endmodule