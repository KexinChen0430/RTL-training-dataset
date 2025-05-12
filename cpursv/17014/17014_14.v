
module nios_system_sram_addr(address,chipselect,clk,reset_n,write_n,writedata,out_port,
                             readdata);

  output [10:0] out_port;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire clk_en;
  reg  [10:0] data_out;
  wire [10:0] out_port;
  wire [10:0] read_mux_out;
  wire [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = data_out & {11{address == 0}};
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else if ((address == 0) && (chipselect && ~write_n)) data_out <= writedata[10:0];
          
      end
  assign readdata = {read_mux_out | 32'b0};
  assign out_port = data_out;
endmodule

