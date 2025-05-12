
module nios_system_alu_control(input  [1:0] address,
                               input  chipselect,
                               input  clk,
                               input  reset_n,
                               input  write_n,
                               input  [31:0] writedata,
                               output [2:0] out_port,
                               output [31:0] readdata);

  wire clk_en;
  reg  [2:0] data_out;
  wire [2:0] out_port;
  wire [2:0] read_mux_out;
  wire [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = {3{address == 0}} & data_out;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else if ((address == 0) && ~write_n && chipselect) data_out <= writedata[2:0];
          
      end
  assign readdata = {29'b0,read_mux_out};
  assign out_port = data_out;
endmodule

