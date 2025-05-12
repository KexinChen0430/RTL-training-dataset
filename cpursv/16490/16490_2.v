
module synchronizer(out,in,clk,reset);

  parameter  DW = 1;
  input  [(-1)+DW:0] in;
  input  clk;
  input  reset;
  output [(-1)+DW:0] out;
  reg  [(-1)+DW:0] sync_reg0;
  reg  [(-1)+DW:0] out;

  
  always @(posedge clk or posedge reset)
      if (reset) 
        begin
          sync_reg0[(-1)+DW:0] <= {DW{1'b0}};
          out[(-1)+DW:0] <= {DW{1'b0}};
        end
      else 
        begin
          sync_reg0[(-1)+DW:0] <= in[(-1)+DW:0];
          out[(-1)+DW:0] <= sync_reg0[(-1)+DW:0];
        end
endmodule

