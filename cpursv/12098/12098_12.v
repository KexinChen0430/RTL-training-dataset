
module jt51_sh  #(parameter  width = 5, stages = 32)
  (input  clk,
   input  [width-1:0] din,
   output [width-1:0] drop);

  reg  [(-1)+stages:0] bits[width-1:0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = 1+i)
          begin : bit_shifter
            
            always @(posedge clk)
                bits[i] <= {bits[i][stages+(-(1+1)):0],din[i]};
            assign drop[i] = bits[i][(-1)+stages];
          end
  endgenerate

endmodule

