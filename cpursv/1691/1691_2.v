
module dut(input  wire clk,
           input  wire enable,
           input  wire [31:0] din,
           output reg [31:0] dout,
           output reg valid);

  
  always @(posedge clk)
      begin
        dout <= 1+din;
        valid <= enable;
      end
endmodule

