module stratixv_hssi_refclk_divider
  #(
      parameter divide_by                   =  1, 
      parameter enabled                     = "false", 
      parameter refclk_coupling_termination = "normal_100_ohm_termination", 
      parameter reference_clock_frequency   = "0 ps", 
      parameter avmm_group_channel_index    = 0, 
      parameter use_default_base_address    = "true", 
      parameter user_base_address           = 0 
  ) (
  input           avmmrstn, 
  input           avmmclk, 
  input           avmmwrite, 
  input           avmmread, 
  input   [ 1:0]  avmmbyteen, 
  input   [10:0]  avmmaddress, 
  input   [15:0]  avmmwritedata, 
  output  [15:0]  avmmreaddata, 
  output          blockselect, 
  input           refclkin, 
  output          refclkout, 
  input           nonuserfrompmaux 
);
reg   rxp_div2;     
wire  rxp_div2_180; 
assign  blockselect   = 1'b0; 
assign  avmmreaddata  = 16'd0; 
assign refclkout  = ( enabled == "false") && ( divide_by == 1 ) ? refclkin : 
                    ( enabled == "false") && ( divide_by == 2 ) ? rxp_div2_180 : 
                    1'bx; 
initial begin
  rxp_div2  = 1'b1; 
  if (enabled != "false")
    $display("[stratixv_hssi_refclk_divider] - ERROR! - Parameter \"enabled\" does not support value %s", enabled); 
end
assign  rxp_div2_180 = ~rxp_div2; 
always @(posedge refclkin)
  rxp_div2  <= ~rxp_div2; 
endmodule