module cyclone10gx_io_ibuf(i, ibar, dynamicterminationcontrol, o); 
parameter differential_mode ="false"; 
parameter bus_hold = "false"; 
parameter simulate_z_as = "Z"; 
parameter lpm_type = "cyclone10gx_io_ibuf"; 
(* iopad_external_pin *) input i; 
(* iopad_external_pin *) input ibar; 
input dynamicterminationcontrol; 
output o; 
endmodule 