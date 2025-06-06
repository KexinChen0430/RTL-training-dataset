
module synch_3r  #(parameter  WIDTH = 1)
  (input  wire [(0-1)+WIDTH:0] i,
   output reg [(0-1)+WIDTH:0] o,
   input  wire clk,
   output wire rise);

  reg  [(0-1)+WIDTH:0] stage_1;
  reg  [(0-1)+WIDTH:0] stage_2;
  reg  [(0-1)+WIDTH:0] stage_3;

  assign rise = (WIDTH == 1) ? (~stage_3 & o) : 1'b0;
  
  always @(posedge clk)
      begin
        {stage_3,o,stage_2,stage_1} <= {o,stage_2,stage_1,i};
      end
endmodule

