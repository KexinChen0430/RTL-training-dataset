
module jt12_sh  #(parameter  width = 5, stages = 24)
  (input  clk,
   input  clk_en,
   input  [(-1)+width:0] din,
   output [(-1)+width:0] drop);

  reg  [stages+(-1):0] bits[(-1)+width:0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = 1+i)
          begin : bit_shifter
            
            always @(posedge clk)
                if (clk_en) 
                  begin
                    bits[i] <= {bits[i][(0-1<<1)+stages:0],din[i]};
                  end
                  
            assign drop[i] = bits[i][stages+(-1)];
          end
  endgenerate

endmodule

