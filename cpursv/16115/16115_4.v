
module mgc_in_wire(d,z);

  parameter integer  rscid = 1;
  parameter integer  width = 8;
  output [width+(0-1):0] d;
  input  [width+(0-1):0] z;
  wire [width+(0-1):0] d;

  assign d = z;
endmodule

