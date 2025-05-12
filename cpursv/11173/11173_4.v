
module memory_decoder(input  wire [7:0] address,
                      input  wire [7:0] data_in,
                      input  wire [7:0] switch_in,
                      input  wire clk,
                      input  wire res,
                      input  wire write_enable,
                      output wire [7:0] LED_status,
                      output wire [7:0] data_out);

  wire [7:0] memory_data_out;
  wire [7:0] switch_data_out;
  wire mem_write_enable,LED_write_enable;

  assign mem_write_enable = write_enable & ~&address;
  sram sram0(.address(address),.data_in(data_in),.clk(clk),
             .write_enable(mem_write_enable),.data_out(memory_data_out));
  assign LED_write_enable = &address & write_enable;
  ff_d #(.WIDTH(8)) led_driver0(.D(data_in),.en(LED_write_enable),
                                .clk(clk),.res(res),.Q(LED_status));
  ff_d #(.WIDTH(8)) switch_driver0(.D(switch_in),.en(1'b1),.clk(clk),
                                   .res(res),.Q(switch_data_out));
  assign data_out = ~&address ? memory_data_out : switch_data_out;
endmodule

