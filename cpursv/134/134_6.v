
module synch_3r  #(parameter  WIDTH = 1)
  (input  wire [WIDTH+(0-1):0] i,
   output reg [WIDTH+(0-1):0] o,
   input  wire clk,
   output wire rise);

  reg  [WIDTH+(0-1):0] stage_1;
  reg  [WIDTH+(0-1):0] stage_2;
  reg  [WIDTH+(0-1):0] stage_3;

  assign rise = (WIDTH == 1) ? (o & ~stage_3) : 1'b0;
  
  always @(posedge clk)
      begin
        {stage_3,o,stage_2,stage_1} <= {o,stage_2,stage_1,i};
      end
endmodule

