
module ADDER(input  wire [63:0] Data_A,
             input  wire [63:0] Data_B,
             output reg [63:0] Result);

  
  always @(*)
      begin
        Result <= Data_A+Data_B;
      end
endmodule

