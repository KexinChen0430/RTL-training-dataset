module cyclonev_hssi_refclk_divider
  #(
      parameter lpm_type                    = "cyclonev_hssi_refclk_divider", 
      parameter divide_by                   =  1,                             
      parameter enabled                     = "false",                        
      parameter refclk_coupling_termination = "normal_100_ohm_termination"    
  ) (
  input           refclkin,       
  output          refclkout,      
  input           nonuserfrompmaux 
);
reg   rxp_div2;     
wire  rxp_div2_180; 
assign refclkout  = ( enabled == "false") && ( divide_by == 1 ) ? refclkin : 
                    ( enabled == "false") && ( divide_by == 2 ) ? rxp_div2_180 : 
                    1'bx; 
initial begin
  rxp_div2  = 1'b1; 
  if (enabled != "false")
    $display("[cyclonev_hssi_refclk_divider] - ERROR! - Parameter \"enabled\" does not support value %s", enabled);
end
assign  rxp_div2_180 = ~rxp_div2; 
always @(posedge refclkin)
  rxp_div2  <= ~rxp_div2; 
endmodule