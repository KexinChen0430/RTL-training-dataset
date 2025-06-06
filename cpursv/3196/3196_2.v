
module pa(input  wire clk,
          input  wire reset,
          input  wire in,
          output wire p);

  reg  [1:0] x;
  reg  [1:0]  init = 0;

  
  always @(posedge clk or posedge reset)
      if (reset) init <= 0;
      else 
        begin
          x <= {x[0],in};
          init <= {init[0],1'b1};
        end
  assign p = (&init & !x[1]) & x[0];
endmodule

