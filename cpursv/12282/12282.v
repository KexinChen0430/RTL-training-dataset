
module tracking_camera_system_sysid_qsys_0(address,clock,reset_n,readdata);

  output [31:0] readdata;
  input  address;
  input  clock;
  input  reset_n;
  wire [31:0] readdata;

  assign readdata = address ? 1424804797 : 0;
endmodule

