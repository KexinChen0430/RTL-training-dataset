module SendConstantgComonent(input clk, input reset, 
    output io_in_ready, 
    input  io_in_valid, 
    input [31:0] io_in_bits, 
    input  io_out_ready, 
    output io_out_valid, 
    output[31:0] io_out_bits, 
    input  io_pcIn_valid, 
    input  io_pcIn_bits_request, 
    input [15:0] io_pcIn_bits_moduleId, 
    input [7:0] io_pcIn_bits_portId, 
    input [15:0] io_pcIn_bits_pcValue, 
    input [3:0] io_pcIn_bits_pcType, 
    output io_pcOut_valid, 
    output io_pcOut_bits_request, 
    output[15:0] io_pcOut_bits_moduleId, 
    output[7:0] io_pcOut_bits_portId, 
    output[15:0] io_pcOut_bits_pcValue, 
    output[3:0] io_pcOut_bits_pcType); 
  reg[3:0] R0; 
  wire T1; 
  assign io_pcOut_bits_pcType = R0; 
  always @(posedge clk) begin 
    if(reset) begin 
      R0 <= 4'h0; 
    end else if(T1) begin 
      R0 <= T6; 
    end
    outputData <= 32'h2; 
  end
endmodule