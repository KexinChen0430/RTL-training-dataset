
module cyclonev_mac(ax,ay,resulta);

  parameter  ax_width = 9;
  parameter  signed_max = true;
  parameter  ay_scan_in_width = 9;
  parameter  signed_may = true;
  parameter  result_a_width = 18;
  parameter  operation_mode = M9x9;
  input  [ax_width-1:0] ax;
  input  [ay_scan_in_width-1:0] ay;
  output [result_a_width+(-1):0] resulta;


endmodule

