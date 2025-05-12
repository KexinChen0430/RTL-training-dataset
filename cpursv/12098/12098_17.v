
module jt51_sh  #(parameter  width = 5, stages = 32)
  (input  clk,
   input  [width-1:0] din,
   output [width-1:0] drop);

  reg  [(0-1)+stages:0] bits[width-1:0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = i+1)
          begin : bit_shifter
            
            always @(posedge clk)
                bits[i] <= {bits[i][stages-2:0],din[i]};
            assign drop[i] = bits[i][(0-1)+stages];
          end
  endgenerate

endmodule

