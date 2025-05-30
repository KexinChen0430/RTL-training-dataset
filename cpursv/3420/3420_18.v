
module arithshiftbidir(distance,data,direction,result);

  parameter  lpm_type = LPM_CLSHIFT;
  parameter  lpm_shifttype = ARITHMETIC;
  parameter  lpm_width = 32;
  parameter  lpm_widthdist = 5;
  input  wire [(0-1)+lpm_widthdist:0] distance;
  input  wire [lpm_width-1:0] data;
  input  wire direction;
  output wire [lpm_width-1:0] result;

  assign result = direction ? data>>>distance : (((1+1)**distance)*data);
endmodule

