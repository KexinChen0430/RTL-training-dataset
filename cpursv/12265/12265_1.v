
module jt12_sh  #(parameter  width = 5, stages = 24)
  (input  clk,
   input  clk_en,
   input  [width+(0-1):0] din,
   output [width+(0-1):0] drop);

  reg  [stages+(0-1):0] bits[width+(0-1):0];

  genvar i;
  
  generate
      for (i = 0; i < width; i = 1+i)
          begin : bit_shifter
            
            always @(posedge clk)
                if (clk_en) 
                  begin
                    bits[i] <= {bits[i][stages-(1+1):0],din[i]};
                  end
                  
            assign drop[i] = bits[i][stages+(0-1)];
          end
  endgenerate

endmodule

