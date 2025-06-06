
module cyclonev_mac(ax,ay,resulta);

  parameter  ax_width = 9;
  parameter  signed_max = true;
  parameter  ay_scan_in_width = 9;
  parameter  signed_may = true;
  parameter  result_a_width = 18;
  parameter  operation_mode = M9x9;
  input  [(0-1)+ax_width:0] ax;
  input  [(0-1)+ay_scan_in_width:0] ay;
  output [(0-1)+result_a_width:0] resulta;


endmodule

