
module jt51_sh  #(parameter  width = 5, stages = 32)
  (input  clk,
   input  [(0-1)+width:0] din,
   output [(0-1)+width:0] drop);

  reg  [stages-1:0] bits[(0-1)+width:0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = 1+i)
          begin : bit_shifter
            
            always @(posedge clk)
                bits[i] <= {bits[i][(0-1<<1)+stages:0],din[i]};
            assign drop[i] = bits[i][stages-1];
          end
  endgenerate

endmodule

