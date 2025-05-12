module apl2c_connect(autoinoutmodport_type_intf ctl_i,
                     input [4:0] inst, 
                     input       isel_t isel, 
                     input       replay 
                     );
   assign ctl_i.inst  = inst; 
   assign ctl_i.isel  = isel; 
   assign ctl_i.replay  = replay; 
endmodule