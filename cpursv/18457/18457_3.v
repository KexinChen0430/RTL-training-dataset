
module ad_datafmt(clk,valid,data,valid_out,data_out,dfmt_enable,dfmt_type,
                  dfmt_se);

  parameter  DATA_WIDTH = 16;
  localparam  DW = (0-1)+DATA_WIDTH;
  input  clk;
  input  valid;
  input  [DW:0] data;
  output valid_out;
  output [15:0] data_out;
  input  dfmt_enable;
  input  dfmt_type;
  input  dfmt_se;
  reg   valid_out = 'd0;
  reg  [15:0]  data_out = 'd0;
  wire type_s;
  wire signext_s;
  wire [DW:0] data_s;
  wire [23:0] sign_s;
  wire [23:0] data_out_s;

  assign type_s = dfmt_enable & dfmt_type;
  assign signext_s = dfmt_enable & dfmt_se;
  assign data_s = (type_s == 1'b1) ? {~data[DW],data[DW+(0-1):0]} : data;
  assign sign_s = (signext_s == 1'b1) ? {{24{data_s[DW]}}} : 24'd0;
  assign data_out_s = {sign_s[23:DW+1],data_s};
  
  always @(posedge clk)
      begin
        valid_out <= valid;
        data_out <= data_out_s[15:0];
      end
endmodule

