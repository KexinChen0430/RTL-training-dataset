
module pio_green(address,chipselect,clk,reset_n,write_n,writedata,out_port,
                 readdata);

  output [8:0] out_port;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire clk_en;
  reg  [8:0] data_out;
  wire [8:0] out_port;
  wire [8:0] read_mux_out;
  wire [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = data_out & {9{address == 0}};
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else if (~write_n && (address == 0) && chipselect) data_out <= writedata[8:0];
          
      end
  assign readdata = {{{(-9)+32}{1'b0}},read_mux_out};
  assign out_port = data_out;
endmodule

