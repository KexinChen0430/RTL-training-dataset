
module mgc_in_wire(d,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  output [(-1)+width:0] d;
  input  [(-1)+width:0] z;
  wire [(-1)+width:0] d;

  assign d = z;
endmodule

