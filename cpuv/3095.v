module OBUFT (
    (* iopad_external_pin *) 
    output O,               
    input I,                
    input T                 
);
    parameter CAPACITANCE = "DONT_CARE"; 
    parameter DRIVE = 12;                
    parameter IOSTANDARD = "DEFAULT";    
    parameter SLEW = "SLOW";             
    parameter IO_LOC_PAIRS = "";         
    assign O = T ? 1'bz : I;
    specify
        (I => O) = 0; 
    endspecify
endmodule 