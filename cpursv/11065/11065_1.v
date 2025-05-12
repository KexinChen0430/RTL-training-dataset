
module sysgen_reinterpret_6f16badb5b(input  [(0-1)+34:0] input_port,
                                     output [(0-1)+34:0] output_port,
                                     input  clk,
                                     input  ce,
                                     input  clr);

  wire signed  [(0-1)+34:0] input_port_1_40;
  wire [(0-1)+34:0] output_port_5_5_force;

  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule

