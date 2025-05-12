
module pipelined_multiplier  #(parameter  WL = 32)
  (input  wire CLK,
   input  wire [(-1)+WL:0] A,
   input  wire [(-1)+WL:0] B,
   output reg [(1+1)*((-1)+WL):0] Out);

  reg  [(-1)+WL:0] a_in,b_in;
  wire [(1+1)*((-1)+WL):0] multi_reg;
  reg  [(1+1)*((-1)+WL):0] pipe1,pipe2,pipe3,pipe4,pipe5;

  assign multi_reg = b_in*a_in;
  
  always @(posedge CLK)
      begin
        a_in <= A;
        b_in <= B;
        pipe1 <= multi_reg;
        pipe2 <= pipe1;
        pipe3 <= pipe2;
        pipe4 <= pipe3;
        pipe5 <= pipe4;
        Out <= pipe5;
      end
endmodule

