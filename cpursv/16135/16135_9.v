
module pio_egmreset(address,chipselect,clk,reset_n,write_n,writedata,out_port,
                    readdata);

  output out_port;
  output readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  writedata;
  wire clk_en;
  reg  data_out;
  wire out_port;
  wire read_mux_out;
  wire readdata;

  assign clk_en = 1;
  assign read_mux_out = data_out & {1{address == 0}};
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else if (~write_n && (address == 0) && chipselect) data_out <= writedata;
          
      end
  assign readdata = read_mux_out;
  assign out_port = data_out;
endmodule

