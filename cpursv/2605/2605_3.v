
module m1(clk,rstn,leds);

  parameter  width = 8;
  input  clk;
  input  rstn;
  output reg [width+(-1):0] leds;

  
  always @(posedge clk or negedge rstn)
      begin
        if (~rstn) leds <= {width{1'b0}};
        else leds <= {{width+(-1){1'b0}},1'b1}+leds;
      end
endmodule

