module tornado_soc_design_EPCS64_atom (
         dclkin,   
         oe,       
         scein,    
         sdoin,    
         data0out  
      )
;
output           data0out;
input            dclkin;
input            oe;
input            scein;
input            sdoin;
wire             data0out;
  assign data0out = sdoin | scein | dclkin | oe;
endmodule