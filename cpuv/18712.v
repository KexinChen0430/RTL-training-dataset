module cyclonev_io_obuf 
  ((* iopad_external_pin *) output o, 
   input i, oe, dynamicterminationcontrol, 
   input [15:0] seriesterminationcontrol, parallelterminationcontrol, 
   input devoe, 
   (* iopad_external_pin *) output obar); 
   parameter open_drain_output = "false"; 
   parameter bus_hold = "false"; 
   parameter shift_series_termination_control = "false"; 
   parameter sim_dynamic_termination_control_is_connected = "false"; 
   parameter lpm_type = "cyclonev_io_obuf"; 
   assign o  = oe ? i : 1'bz; 
endmodule 