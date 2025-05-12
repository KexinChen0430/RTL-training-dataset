module dflipflop_post_build(din, clk, reset, dout);
  input din; 
  input clk; 
  input reset; 
  output reg dout; 
  always begin : dflipflop_behaviour
    reg state_dflipflop; 
    reg joins_dflipflop; 
    reg read_dflipflop_din_ln8; 
    joins_dflipflop = 1'b0;
    if (reset) begin
      dout <= 1'b0;
      joins_dflipflop = 1'b1;
    end
    else begin
      read_dflipflop_din_ln8 = din;
      dout <= read_dflipflop_din_ln8;
      joins_dflipflop = 1'b1;
    end
    if (joins_dflipflop == 1'b1) begin
      joins_dflipflop = 1'b0;
      state_dflipflop <= 1'b0;
    end
    @(posedge clk);
  end
endmodule