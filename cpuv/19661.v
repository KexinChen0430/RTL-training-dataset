module cyclone10gx_io_obuf(
    i,                          
    oe,                         
    dynamicterminationcontrol,  
    seriesterminationcontrol,   
    parallelterminationcontrol, 
    devoe,                      
    o,                          
    obar                        
);
parameter open_drain_output = "false";                       
parameter bus_hold = "false";                                
parameter shift_series_termination_control = "false";        
parameter sim_dynamic_termination_control_is_connected = "false"; 
parameter lpm_type = "cyclone10gx_io_obuf";                  
input i;                          
input oe;                         
input devoe;                      
input dynamicterminationcontrol;  
input [15:0] seriesterminationcontrol; 
input [15:0] parallelterminationcontrol; 
(* iopad_external_pin *) output o;    
(* iopad_external_pin *) output obar; 
endmodule