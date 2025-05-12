
module cyclone10gx_mac(ax,ay,resulta);

  parameter  ax_width = 18;
  parameter  signed_max = true;
  parameter  ay_scan_in_width = 18;
  parameter  signed_may = true;
  parameter  result_a_width = 36;
  parameter  operation_mode = M18X18_FULL;
  input  [(-1)+ax_width:0] ax;
  input  [ay_scan_in_width-1:0] ay;
  output [result_a_width-1:0] resulta;


endmodule

