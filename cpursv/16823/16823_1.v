
module tdata_design_1_axis_broadcaster_0_0  #(parameter 
       C_S_AXIS_TDATA_WIDTH = 8,
       C_M_AXIS_TDATA_WIDTH = 8)
  (input  wire [(0-1)+C_S_AXIS_TDATA_WIDTH:0] tdata,
   output wire [C_M_AXIS_TDATA_WIDTH+(0-1):0] tdata_out);

  assign tdata_out = {tdata[7:0],tdata[7:0]};
endmodule

