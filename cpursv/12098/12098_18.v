
module jt51_sh  #(parameter  width = 5, stages = 32)
  (input  clk,
   input  [(-1)+width:0] din,
   output [(-1)+width:0] drop);

  reg  [(-1)+stages:0] bits[(-1)+width:0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = i+1)
          begin : bit_shifter
            
            always @(posedge clk)
                bits[i] <= {bits[i][stages-2:0],din[i]};
            assign drop[i] = bits[i][(-1)+stages];
          end
  endgenerate

endmodule

