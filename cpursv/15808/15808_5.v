
module driver_vga_1024x768(clk_vga,hs,vs,hc_visible,vc_visible);

  input  clk_vga;
  output hs,vs;
  output [10:0] hc_visible;
  output [10:0] vc_visible;
  parameter  hpixels = 11'd1360;
  parameter  vlines = 11'd805;
  parameter  hfp = 11'd64;
  parameter  hsc = 11'd104;
  parameter  hbp = 11'd168;
  parameter  vfp = 11'd3;
  parameter  vsc = 11'd4;
  parameter  vbp = 11'd30;
  reg  [10:0] hc,hc_next,vc,vc_next;

  assign hc_visible = ((hc > (hbp+hsc)) && (hc < ((0-hfp)+hpixels))) ? (hc-(hbp+hsc)) : 10'd0;
  assign vc_visible = ((vc < (vlines-vfp)) && (vc > (vbp+vsc))) ? (vc-(vbp+vsc)) : 10'd0;
  
  always @(*)
      if (hc == hpixels) hc_next = 11'd0;
      else hc_next = hc+11'd1;
  
  always @(*)
      if (hc == 11'd0) 
        if (vc == vlines) vc_next = 11'd0;
        else vc_next = 11'd1+vc;
      else vc_next = vc;
  
  always @(posedge clk_vga)
      {hc,vc} <= {hc_next,vc_next};
  assign hs = (hc < hsc) ? 1'b0 : 1'b1;
  assign vs = (vc < vsc) ? 1'b0 : 1'b1;
endmodule

