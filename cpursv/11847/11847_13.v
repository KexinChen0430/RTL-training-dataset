
module jt12_sh_rst  #(parameter  width = 5, stages = 32, rstval = 1'b0)
  (input  rst,
   input  clk,
   input  clk_en,
   input  [width+(0-1):0] din,
   output [width+(0-1):0] drop);

  reg  [stages+(0-1):0] bits[width+(0-1):0];

  genvar i;
  integer k;

  
  generate
      
      initial        for (k = 0; k < width; k = 1+k)
          begin
            bits[k] = {stages{rstval}};
          end
  endgenerate

  
  generate
      for (i = 0; i < width; i = i+1)
          begin : bit_shifter
            
            always @(posedge clk or posedge rst)
                if (rst) 
                  begin
                    bits[i] <= {stages{rstval}};
                  end
                else if (clk_en) 
                  begin
                    bits[i] <= {bits[i][stages-1<<1:0],din[i]};
                  end
                  
            assign drop[i] = bits[i][stages+(0-1)];
          end
  endgenerate

endmodule

